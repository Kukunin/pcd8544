$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pcd8544'

RSpec.configure do |config|
  config.before(:suite) do
    PiPiper::Platform.driver = PiPiper::StubDriver.new
  end
end
