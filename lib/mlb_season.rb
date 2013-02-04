class MlbSeason
	attr_accessor :mlb_teams,:mlb_games,:mlb_fields,:mlb_year

	def initialize
		@mlb_games = {}
		@mlb_teams = {}
	end
end