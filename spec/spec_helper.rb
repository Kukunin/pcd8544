$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pcd8544'

module PiPiperContext
  extend RSpec::SharedContext

  let(:stub_driver) { PiPiper::StubDriver.new }

  before do
    PiPiper::Platform.driver = stub_driver
  end
end

RSpec.configure do |config|
  config.include PiPiperContext
end
