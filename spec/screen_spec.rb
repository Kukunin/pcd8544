require "spec_helper"
require "pi_piper"

RSpec.describe Pcd8544::Screen do
  let(:screen) { Pcd8544::Screen.new }

  describe "GPIO pins" do
    context "by default" do
      it "has configured pins" do
        expect(screen.pins.count).to eq 6
        expect(screen.pins[:SCE].pin).to eq 8
        expect(screen.pins[:RESET].pin).to eq 24
        expect(screen.pins[:DC].pin).to eq 23
        expect(screen.pins[:SDIN].pin).to eq 10
        expect(screen.pins[:SCLK].pin).to eq 11
        expect(screen.pins[:LED].pin).to eq 18
      end
    end

    context "with custom options" do
      it "uses custom options" do
        screen = Pcd8544::Screen.new pins: { SCE: 4 }
        expect(screen.pins[:SCE]).to be_a PiPiper::Pin
        expect(screen.pins[:SCE].pin).to eq 4
      end
    end
  end

  describe "#light" do
    let(:led_pin) { screen.pins[:LED].pin }

    context "with true" do
      it "turns light" do
        screen.light(true)
        expect(stub_driver.pin_read(led_pin)).to eq Pcd8544::GPIO_HIGH
        expect(screen.light?).to be_truthy
      end

      context "and already lighted" do
        before { screen.light(true) }

        it "does do nothing" do
          expect(stub_driver)
            .to_not receive(:pin_set).with(led_pin, Pcd8544::GPIO_HIGH)
          screen.light(true)
        end
      end
    end

    context "with false" do
      it "turns off light" do
        screen.light(false)
        expect(stub_driver.pin_read(led_pin)).to eq Pcd8544::GPIO_LOW
        expect(screen.light?).to be_falsey
      end
    end
  end
end
