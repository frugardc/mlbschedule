class MlbSeason
	attr_accessor :mlb_teams,:mlb_games,:mlb_fields,:mlb_year

	def initialize
		@mlb_games = {}
		@mlb_teams = {}
		@mlb_fields = {}
	end

	def self.find(season = Time.now.year)
		return Mlbschedule.season(season)
	end

	def schedule
		dates = {}
		Date.new(@mlb_year.to_i).upto(Date.new(@mlb_year.to_i + 1)).each{|date| dates[date.to_s] = []}
		@mlb_games.each do |game_id,game|
			dates[game.mlb_game_time.strftime("%Y-%m-%d")] << game
		end
		return dates
	end
end