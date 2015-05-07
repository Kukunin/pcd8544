module Pcd8544::InstructionMode
  def ensure_data_mode
    return if data_mode?
    @pins[:DC].on
    @instruction_mode = :data
  end

  def data_mode?
    @instruction_mode == :data
  end

  def ensure_command_mode
    return if command_mode?
    @pins[:DC].off
    @instruction_mode = :command
  end

  def command_mode?
    !data_mode?
  end
end
