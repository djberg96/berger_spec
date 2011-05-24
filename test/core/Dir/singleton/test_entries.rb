######################################################################
# test_entries.rb
#
# Test case for the Dir.entries class method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Dir_Entries_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @pwd = Dir.pwd
    if WINDOWS
      @entries = `dir /A /B`.split("\n").push('.', '..')
    else
      @entries = `ls -a1`.split("\n")
      @entries.push('.') unless @entries.include?('.')
      @entries.push('..') unless @entries.include?('..')
    end
  end

  test "entries basic functionality" do
    assert_respond_to(Dir, :entries)
    assert_nothing_raised{ Dir.entries(@pwd) }
    assert_kind_of(Array, Dir.entries(@pwd))
  end

  test "entries returns the expected results" do
    assert_equal(@entries.sort, Dir.entries(@pwd).sort)
  end

  test "entries requires one argument" do
    assert_raise(ArgumentError){ Dir.entries }
    assert_raise(ArgumentError){ Dir.entries(@pwd, @pwd) }
  end

  test "entries requires a string argument" do
    assert_raise(TypeError){ Dir.entries(1) }
  end

  test "entries raises SystemCallError if the directory does not exist" do
    assert_raise_kind_of(SystemCallError){ Dir.entries("bogus") }
  end

  def teardown
    @pwd     = nil
    @entries = nil
  end
end
