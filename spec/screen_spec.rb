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

end
