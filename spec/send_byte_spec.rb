require "spec_helper"

RSpec.describe Pcd8544::Screen do
  let(:screen) { Pcd8544::Screen.new }

  describe "#send_byte" do
    let(:sclk_pin) { screen.pins[:SCLK] }
    let(:sdin_pin) { screen.pins[:SDIN] }

    before do
      @signals = []
      allow(sdin_pin).to receive(:off) { @signals << 0 }
      allow(sdin_pin).to receive(:on)  { @signals << 1 }
      allow(sclk_pin).to receive(:off) { @signals << 2 }
      allow(sclk_pin).to receive(:on)  { @signals << 3 }
    end

    {
      0x00 => [0,3,2,0,3,2,0,3,2,0,3,2,0,3,2,0,3,2,0,3,2,0,3,2],
      0x77 => [0,3,2,1,3,2,1,3,2,1,3,2,0,3,2,1,3,2,1,3,2,1,3,2],
      0xFF => [1,3,2,1,3,2,1,3,2,1,3,2,1,3,2,1,3,2,1,3,2,1,3,2]
    }.each do |byte, signals|
      context "with #{byte.to_s(16)} byte" do
        it "sets correct signals to pins" do
          screen.send_byte byte
          expect(@signals).to eq signals
        end
      end
    end

    context "with incomplete bytes" do
      it "sends full bytes anyway" do
        screen.send_byte 0x123
        expect(@signals.count).to eq 16*3
      end
    end
  end
end
