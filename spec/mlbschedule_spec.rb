require 'spec_helper'

describe Mlbschedule do
  it "downloads the ICS file and load calendar" do
  	Mlbschedule.load(2013)
  end
end