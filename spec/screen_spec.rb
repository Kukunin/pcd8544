require "spec_helper"

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

  describe "#send_byte" do
    let(:sclk_pin) { screen.pins[:SCLK].pin }
    let(:sdin_pin) { screen.pins[:SDIN].pin }

    [0x00, 0x77, 0xFF].each do |byte|
      context "with #{byte.to_s(16)} byte" do
        before do
          allow(stub_driver).to receive(:pin_set)
          screen.send_byte byte
        end

        it "clocks eight times" do
          expect(stub_driver).to have_received(:pin_set)
            .with(sclk_pin, Pcd8544::GPIO_HIGH)
            .exactly(8).times
        end

        it "sets SDIN pin eight times" do
          expect(stub_driver).to have_received(:pin_set)
            .with(sdin_pin, anything)
            .exactly(8).times
        end
      end
    end
  end
end
