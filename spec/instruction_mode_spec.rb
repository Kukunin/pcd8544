require "spec_helper"

RSpec.describe Pcd8544::Screen do
  let(:screen) { Pcd8544::Screen.new }
  let(:dc_pin) { screen.pins[:DC] }

  describe "#ensure_data_mode" do
    before do
      allow(dc_pin).to receive(:on)
      screen.ensure_command_mode
    end
    it "switches DC pin to HIGH only once" do
      screen.ensure_data_mode
      screen.ensure_data_mode

      expect(dc_pin).to have_received(:on).once
      expect(screen).to be_data_mode
    end
  end

  describe "#ensure_command_mode" do
    before do
      allow(dc_pin).to receive(:off)
      screen.ensure_data_mode
    end
    it "switches DC pin to HIGH only once" do
      screen.ensure_command_mode
      screen.ensure_command_mode

      expect(dc_pin).to have_received(:off).once
      expect(screen).to be_command_mode
    end
  end

  describe "#command_mode?" do
    it "is true by default" do
      expect(screen).to be_command_mode
    end
  end
end
