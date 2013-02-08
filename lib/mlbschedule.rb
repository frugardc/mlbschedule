#require "mlbschedule/version"
require 'icalendar'
require 'geocoder'
require "#{File.expand_path(File.dirname(__FILE__))}/mlb_season.rb"
require "#{File.expand_path(File.dirname(__FILE__))}/mlb_team.rb"
require "#{File.expand_path(File.dirname(__FILE__))}/mlb_field.rb"
require "#{File.expand_path(File.dirname(__FILE__))}/mlb_game.rb"
module Mlbschedule
	def self.retrieve_data(season = Time.now.year.to_s,refresh = false)
		if refresh or ( File.exist?("#{File.expand_path(File.dirname(__FILE__))}/../data/raw_#{season}.dmp") == false )
			teams = {}
			require 'open-uri'
			100.upto(200) do |i|
				url = "http://mlb.mlb.com/soa/ical/schedule.ics?team_id=#{i}&season=#{season}"
				cal_file = open(url, "User-Agent" => "Chrome Browser")
				cals = Icalendar.parse(cal_file)
				cal = cals.first
				if cal.events.size > 162
					name = cal.properties["x-wr_calname"].gsub(" Schedule","").gsub("#{season} ","").to_s
					teams[name] = cal
				end
			end
			File.open("#{File.expand_path(File.dirname(__FILE__))}/../data/raw_#{season}.dmp","w").write(Marshal.dump(teams))
		else
			teams = Marshal.load(File.read("#{File.expand_path(File.dirname(__FILE__))}/../data/raw_#{season}.dmp"))
		end
		return teams
	end

	def self.save(season = Time.now.year.to_s, refresh = false)
		mlb_season = MlbSeason.new
		mlb_season.mlb_year = season
		data = self.retrieve_data(season,refresh)
		data.each do |team_name,calendar|
			team = MlbTeam.new
			team.name = team_name
			calendar.events.each do |event|
				game = MlbGame.new
				game.mlb_game_time = event.dtend
				game.mlb_game_id = event.uid
				game.description = event.description
				mlb_field = mlb_season.mlb_fields[event.location]
				if not mlb_field
					mlb_field = MlbField.new({:name => event.location})
					mlb_season.mlb_fields[event.location] = mlb_field
				end
				mlb_field.mlb_game_ids << game.mlb_game_id
				game.mlb_field = mlb_field
				mlb_season.mlb_games[event.uid] = game
				team.mlb_game_ids << event.uid
			end
			team.mlb_season = mlb_season
			mlb_season.mlb_teams[team_name] = team
		end
		File.open("#{File.expand_path(File.dirname(__FILE__))}/../data/processed_#{season}.dmp","w").write(Marshal.dump(mlb_season))
	end

	def self.season(season = Time.now.year.to_s, refresh= false)
		if refresh or ( File.exist?("#{File.expand_path(File.dirname(__FILE__))}/../data/processed_#{season}.dmp") == false )
			self.save(season,true)
		end
		Marshal.load(File.read("#{File.expand_path(File.dirname(__FILE__))}/../data/processed_#{season}.dmp"))
	end
end
