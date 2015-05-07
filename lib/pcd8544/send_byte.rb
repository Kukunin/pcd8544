module Pcd8544::SendByte
  def send_byte(byte)
    bit_array = byte.to_s(2).split('').map &:to_i

    (8 - (bit_array.size % 8)).times do # align to 8 bits
      @pins[:SDIN].off
      @pins[:SCLK].on
      @pins[:SCLK].off
    end unless bit_array.size % 8 == 0 && bit_array.size > 0

    bit_array.each do |bit|
      @pins[:SDIN].update_value bit
      @pins[:SCLK].on
      @pins[:SCLK].off
    end
  end
end
