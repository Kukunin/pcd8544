module Pcd8544::FunctionSet
  def ensure_basic_set
    return if basic_set?
    send_byte 0x20
    @function_set = :basic
  end

  def basic_set?
    !extended_set?
  end

  def ensure_extended_set
    return if extended_set?
    send_byte 0x21
    @function_set = :extended
  end

  def extended_set?
    @function_set == :extended
  end
end
