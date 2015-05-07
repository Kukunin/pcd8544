require "spec_helper"

RSpec.describe Pcd8544::Screen do
  let(:screen) { Pcd8544::Screen.new }
  before { allow(screen).to receive(:send_byte) }

  describe "#ensure_basic_set" do
    before { screen.ensure_extended_set }

    it "sends special byte only once" do
      screen.ensure_basic_set
      screen.ensure_basic_set

      expect(screen).to have_received(:send_byte).with(0x20).once
      expect(screen).to be_basic_set
    end
  end

  describe "#ensure_command_mode" do
    before { screen.ensure_basic_set }

    it "sends special byte only once" do
      screen.ensure_extended_set
      screen.ensure_extended_set

      expect(screen).to have_received(:send_byte).with(0x21).once
      expect(screen).to be_extended_set
    end
  end

  describe "#basic_set?" do
    it "is true by default" do
      expect(screen).to be_basic_set
    end
  end
end
