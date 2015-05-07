module Pcd8544::Backlight
  def backlight(value)
    return if @backlight == value
    @pins[:LED].update_value value
    @backlight = value
  end

  def backlight?
    @backlight
  end
end
