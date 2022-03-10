###############################################################################
# test_list.rb
#
# Test case for the Signal.list class method.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_Signal_List_ClassMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @list = nil
  end

  test "list basic functionality" do
    assert_respond_to(Signal, :list)
    assert_nothing_raised{ Signal.list }
    assert_kind_of(Hash, Signal.list)
  end

  test "list returns expected results" do
    @list = Signal.list

    if WINDOWS
      assert_true(@list.has_key?('KILL'))
    else
      assert_true(@list.has_key?('ALRM'))
      assert_true(@list.has_key?('BUS'))
      assert_true(@list.has_key?('CHLD'))
      assert_true(@list.has_key?('HUP'))
      assert_true(@list.has_key?('KILL'))
      assert_true(@list.has_key?('TERM'))
    end
  end

  test "list values are always numeric" do
    Signal.list.each{ |key, val| assert_kind_of(Integer, val) }
  end

  test "list method does not accept any arguments" do
    assert_raise(ArgumentError){ Signal.list(true) }
  end

  def teardown
    @list = nil
  end
end
