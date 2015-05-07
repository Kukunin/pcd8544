require "spec_helper"

RSpec.describe Pcd8544::Screen do
  let(:screen) { Pcd8544::Screen.new }

  describe "#backlight" do
    let(:led_pin) { screen.pins[:LED] }

    context "with true" do
      it "turns backlight only once" do
        allow(led_pin).to receive(:on)
        screen.backlight(true)
        screen.backlight(true)
        expect(led_pin).to have_received(:on).once
        expect(screen.backlight?).to be_truthy
      end
    end

    context "with false" do
      it "turns off backlight only once" do
        allow(led_pin).to receive(:off)
        screen.backlight(false)
        screen.backlight(false)
        expect(led_pin).to have_received(:off).once
        expect(screen.backlight?).to be_falsey
      end
    end
  end
end
