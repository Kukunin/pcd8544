require 'active_support/core_ext/hash/deep_merge'

require "pcd8544/version"
require "pcd8544/ascii"
require "pcd8544/screen"

module Pcd8544
  include PiPiper::PinValues
end
