############################################################################
# test_struct_tms.rb
#
# Test case for the special Process::Tms structure (formerly Struct::Tms).
# Although this is # technically a "core" class, it's really just a special
# type of Struct returned by the Process.times method.
############################################################################
require 'test/helper'
require 'test/unit'

class TC_StructTms < Test::Unit::TestCase
  def setup
    @times = Process.times
  end

  test "Process.times returns a struct with the expected members" do
    assert_kind_of(Process::Tms, @times)
    assert_respond_to(@times, :utime)
    assert_respond_to(@times, :stime)
    assert_respond_to(@times, :cutime)
    assert_respond_to(@times, :cstime)
  end

  test "struct members are floats" do
    assert_kind_of(Float, @times.utime)
    assert_kind_of(Float, @times.stime)
    assert_kind_of(Float, @times.cutime)
    assert_kind_of(Float, @times.cstime)
  end

  def teardown
    @times = nil
  end
end
