#require "mlbschedule/version"
require 'icalendar'
module Mlbschedule
	def self.retrieve_data(season = Time.now.year.to_s)
		teams = {}
		require 'open-uri'
		100.upto(200) do |i|
			#begin
				url = "http://mlb.mlb.com/soa/ical/schedule.ics?team_id=#{i}&season=#{season}"
				puts url
				cal_file = open(url, "User-Agent" => "Chrome Browser")
				cals = Icalendar.parse(cal_file)
				cal = cals.first
				if cal.events.size > 162
					name = cal.properties["x-wr_calname"].gsub(" Schedule","").gsub("#{season} ","").to_s
					teams[name] = cal
				end
			#rescue
			#	puts "Nothing for i"
				#return teams
			#end
		end
		return teams
	end

	def self.save(season = Time.now.year.to_s)
		File.open("../data/season.dmp","w").write(Marshal.dump(self.retrieve_data(season)))
	end

	def self.teams(season = Time.now.year.to_s, refresh= false)
		if refresh
			self.save(season)
		end
		Marshal.load(File.read("../data/season.dmp"))
	end
end
