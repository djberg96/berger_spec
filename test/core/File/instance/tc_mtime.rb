#####################################################################
# tc_mtime.rb
#
# Test case for the File#mtime instance method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_File_Mtime_InstanceMethod < Test::Unit::TestCase
  def setup
    @name = File.expand_path(__FILE__)
    @file = File.open(@name)
  end

  test "mtime basic functionality" do
    assert_respond_to(@file, :mtime)
    assert_nothing_raised{ @file.mtime }
    assert_kind_of(Time, @file.mtime)
  end

  test "mtime fails on a closed handle" do
    @file.close
    assert_raise(IOError){ @file.mtime }
  end

  test "mtime does not accept any arguments" do
    assert_raises(ArgumentError){ @file.mtime(@name) }
  end

  def teardown
    @file.close if @file && !@file.closed?
    @name = nil
    @file = nil
  end
end
