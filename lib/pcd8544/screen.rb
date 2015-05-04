require 'pi_piper'

class Pcd8544::Screen
  WIDTH = 84
  HEIGHT = 48

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

  def set_initial
    # Reset the controller
    @pins[:RESET].off
    @pins[:RESET].on

    @pins[:DC].off
    send_byte 0x21 # Extended Instruction Set
    send_byte 0xBF # Vop (Contrast)
    send_byte 0x07 # Temp Coefficient
    send_byte 0x14 # Bias mode 1:48
    send_byte 0x20 # Basic Instruction Set
    send_byte 0x0C # Normal display
  end

  def draw_string(string)
    string.split('').each do |symbol|
      draw_symbol symbol
    end
  end

  def draw_symbol(symbol)
    bytes = Pcd8544::ASCII[symbol.ord - 0x20]

    @pins[:DC].on
    send_byte 0x00
    bytes.each { |byte| send_byte byte }
    send_byte 0x00
  end

  def clear
    @pins[:DC].off
    send_byte 0x80 # reset X pointer
    send_byte 0x40 # reset Y pointer

    @pins[:DC].on
    (WIDTH * HEIGHT / 8).times do
      send_byte 0x00
    end
  end
end
