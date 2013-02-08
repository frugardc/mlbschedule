class MlbField
	attr_accessor :name,:team,:lat,:lng,:city,:state,:mlb_game_ids,:mlb_season
	def initialize(attributes)
		attributes.each do |key,val|
			if self.respond_to?(key)
				self.send("#{key}=",val)
			end
		end
		if self.name
			sleep 0.5
			geocode = Geocoder.search(self.name)
			if gcode = geocode.first
				self.city = gcode.city
				self.lat = gcode.latitude
				self.lng = gcode.longitude
				self.state = gcode.state
			end
		end
		@mlb_game_ids = []
	end
	def mlb_games
		@mlb_season.mlb_games.values_at(*@mlb_game_ids)
	end
end