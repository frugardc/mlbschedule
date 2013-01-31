require "mlbschedule/version"
require 'open-uri'
require 'icalendar'
module Mlbschedule
	def self.load(season = Time.now.year.to_s)
		cal_file = open("http://mlb.mlb.com/soa/ical/schedule.ics?team_id=121&season=#{season}")
		cals = Icalendar.parse(cal_file)
		cal = cals.first
	end
	# http://mlb.mlb.com/soa/ical/schedule.ics?season=2013
  # Your code goes here...
end
