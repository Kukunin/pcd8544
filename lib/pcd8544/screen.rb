require 'pi_piper'

class Pcd8544::Screen
  attr_reader :pins

  def initialize(options = {})
    options = {
      pins: {
        SCE: 8,
        RESET: 24,
        DC: 23,
        SDIN: 10,
        SCLK: 11,
        LED: 18
      }
    }.deep_merge(options)

    @pins = {}
    [:SCE, :RESET, :DC, :SDIN, :SCLK, :LED].each do |pin|
      @pins[pin] = PiPiper::Pin.new :pin => options[:pins][pin], :direction => :out
    end
  end

  def light(value)
    return if @light == value
    @pins[:LED].update_value value
    @light = value
  end

  def light?
    @light
  end

  def send_byte(byte)
    bit_array = byte.to_s(2).split('').map &:to_i

    (8 - bit_array.size).times do # align to 8 bits
      @pins[:SDIN].off
      @pins[:SCLK].on
      @pins[:SCLK].off
    end
    bit_array.each do |bit|
      @pins[:SDIN].update_value bit
      @pins[:SCLK].on
      @pins[:SCLK].off
    end
  end
end
