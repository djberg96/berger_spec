#####################################################################
# test_and.rb
#
# Test case for 'false &'. We use the stringio class here to verify
# the difference in handling between '&' and '&&'.
#####################################################################
require 'test/helper'
require 'stringio'

class TC_FalseClass_And_InstanceMethod < Test::Unit::TestCase
  def setup
    @sio = StringIO.new
  end

  # Helper method we use in other tests
  def lookup(val)
    @sio.write(val)
    @sio.rewind
  end

  test "and basic functionality" do
    assert_respond_to(false, :&)
    assert_nothing_raised{ false.&(0) }
    assert_nothing_raised{ false & 0 }
  end

  test "false with single & and numeric RHS value" do
    assert_false(false & 0)
    assert_false(false & 1)
  end

  test "false with single & and boolean RHS value" do
    assert_false(false & true)
    assert_false(false & false)
  end

  test "false with single & and string RHS value" do
    assert_nothing_raised{ false & lookup('cat') }
    assert_equal('cat', @sio.read(100))
  end

  test "false with double & and numeric RHS value" do
    assert_false(false && 0)
    assert_false(false && 1)
  end

  test "false with double & and boolean RHS value" do
    assert_false(false && true)
    assert_false(false && false)
  end

  test "false with double & and string RHS value" do
    assert_nothing_raised{ false && lookup('cat') }
    assert_nil(@sio.read(100))
  end

  def teardown
    @sio = nil
  end
end
