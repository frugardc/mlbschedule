class MlbTeam
	attr_accessor :name,:league,:mlb_games,:mlb_game_ids,:mlb_season
	def initialize
		@mlb_game_ids = []
	end

	def mlb_games
		@mlb_season.mlb_games.values_at(*@mlb_game_ids)
	end
end