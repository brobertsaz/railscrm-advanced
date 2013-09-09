# Load the rails application
require File.expand_path('../application', __FILE__)
require 'gibberish'

# Initialize the rails application
SassRailscrm::Application.initialize!
::KEY = Gibberish::AES.new("awerwrREWdfER1645")
