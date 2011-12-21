######################################################################
# test_foreach.rb
#
# Test case for the Dir.foreach class method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Dir_Foreach_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    if WINDOWS
      @entries = `dir /A /B`.split("\n").push('.', '..')
    else
      @entries = `ls -a1`.split("\n")
      @entries.push('.') unless @entries.include?('.')
      @entries.push('..') unless @entries.include?('..')
    end
    @pwd = Dir.pwd
  end

  test "foreach basic functionality" do
    assert_respond_to(Dir, :foreach)
    assert_nothing_raised{ Dir.foreach(@pwd){ } }
  end

  test "foreach yields the expected results" do
    entries = []
    assert_nothing_raised{ Dir.foreach(@pwd){ |e| entries.push(e) } }
    assert_equal(entries.sort, @entries.sort)
  end

  test "foreach requires a block" do
    assert_raises(LocalJumpError){ Dir.foreach(@pwd) }
  end

  test "foreach requires one argument only" do
    assert_raises(ArgumentError){ Dir.foreach }
    assert_raises(ArgumentError){ Dir.foreach(@pwd, @pwd) }
  end

  test "foreach requires a string argument" do
    assert_raises(TypeError){ Dir.foreach(1){} }
    assert_raises(TypeError){ Dir.foreach([]){} }
  end

  def teardown
    @pwd     = nil
    @entries = nil
  end
end
