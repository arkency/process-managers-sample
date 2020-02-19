require_relative '../../test/test_helper'
require_relative '../lib/workshops'

class FakeCommandBus
  attr_reader :commands

  def initialize
    @commands = []
  end

  def call(command)
    @commands << command
  end
end