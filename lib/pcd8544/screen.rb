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
end
