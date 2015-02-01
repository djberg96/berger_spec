##############################################
# test_new.rb
#
# Test suite for the Dir.new class method.
##############################################
require 'test/helper'
require 'test/unit'

class TC_Dir_New_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @dir = base_file(__FILE__, "test")
    Dir.mkdir(@dir)
  end

  test "new basic functionality" do
    assert_respond_to(Dir, :new)
    assert_nothing_raised{ Dir.new(@dir) }
  end

  test "new returns a Dir object" do
    assert_kind_of(Dir, Dir.new(@dir))
  end

  test "new requires one argument only" do
    assert_raise(ArgumentError){ Dir.new }
    assert_raise(ArgumentError){ Dir.new(@dir, @dir) }
  end

  test "the argument to new must actually exist" do
    assert_raise_kind_of(SystemCallError){ Dir.new("bogus") }
  end

  test "the argument to new must be a string" do
    assert_raise(TypeError){ Dir.new(nil) }
    assert_raise(TypeError){ Dir.new(true) }
  end

  def teardown
    Dir.rmdir(@dir) if File.exist?(@dir)
  end
end
