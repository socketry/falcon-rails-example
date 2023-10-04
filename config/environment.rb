# Load the Rails application.
require_relative "application"

require 'console/adapter/rails'
Console::Adapter::Rails.apply!

# Initialize the Rails application.
Rails.application.initialize!
