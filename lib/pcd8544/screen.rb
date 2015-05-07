require 'pi_piper'
require 'pcd8544/backlight'
require 'pcd8544/send_byte'
require 'pcd8544/instruction_mode'
require 'pcd8544/function_set'

class Pcd8544::Screen
  include Pcd8544::Backlight
  include Pcd8544::SendByte
  include Pcd8544::InstructionMode
  include Pcd8544::FunctionSet

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
