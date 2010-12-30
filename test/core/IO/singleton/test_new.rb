######################################################################
# test_new.rb
#
# Test case for the IO.new class method, and the IO.for_fd alias.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_IO_New_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @stream = nil
  end

  test "new basic functionality" do
    assert_respond_to(IO, :new)
  end

  test "new returns an IO object" do
    assert_nothing_raised{ @stream = IO.new(2) }
    assert_kind_of(IO, @stream)
  end

  test "for_fd is an alias for new" do
    assert_respond_to(IO, :for_fd)
    assert_alias_method(IO, :new, :for_fd)
  end

  test "new accepts a modestring" do
    assert_nothing_raised{ @stream = IO.new(2, 'w') }
    assert_kind_of(IO, @stream)
  end

  test "new accepts a maximum of two arguments" do
    assert_raise(ArgumentError){ IO.new(2, 'w', 2) }
  end

  test "the first argument to new must be an integer" do
    assert_raise(TypeError){ IO.new("test") }
  end

  test "an invalid integer to new causes an error" do
    assert_raise_kind_of(SystemCallError){ IO.new(999) }
  end

  def teardown
    @stream = nil
  end
end
