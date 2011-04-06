######################################################################
# test_rewind.rb
#
# Test case for the Dir#rewind instance method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Dir_Rewind_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @pwd = pwd_n
    @dir = Dir.new(@pwd)
  end

  test "rewind basic functionality" do
    assert_respond_to(@dir, :rewind)
    assert_nothing_raised{ @dir.rewind }
  end

  test "rewind behaves as expected" do
    first = @dir.read
    assert_nothing_raised{ @dir.rewind }
    assert_equal(0, @dir.tell)
    assert_equal(first, @dir.read)
  end

  test "rewind returns itself" do
    assert_kind_of(Dir, @dir.rewind)
  end

  test "calling rewind multiple times is effectively a no-op" do
    assert_nothing_raised{ 5.times{ @dir.rewind } }
  end

  test "rewind does not accept any arguments" do
    assert_raises(ArgumentError){ @dir.rewind(2) }
  end

  def teardown
    @pwd = nil
    @dir = nil
  end
end
