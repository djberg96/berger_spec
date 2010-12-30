#####################################################################
# test_chmod.rb
#
# Test case for the File#chmod instance method.
#####################################################################
require 'test/helper'
require 'test/unit'

class TC_File_Chmod_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @name1 = File.expand_path(__FILE__)
    @name2 = base_file(__FILE__, 'test_atime.rb')
    @file1 = File.open(@name1)
    @file2 = File.open(@name2)
    @mode1 = File.stat(@name1).mode
    @mode2 = File.stat(@name2).mode
  end

  test "chmod basic functionality" do
    assert_respond_to(@file1, :chmod)
    assert_nothing_raised{ @file1.chmod(0644) }
  end

  test "chmod to 664 works as expected" do
    assert_nothing_raised{ @file1.chmod(0644) }
    assert_equal(0, @file1.chmod(0644))
    assert_equal('100644', File.stat(@name1).mode.to_s(8))
  end

  test "chmod to 444 works as expected" do
    assert_nothing_raised{ @file2.chmod(0444) }
    assert_equal(0, @file2.chmod(0444))
    assert_equal('100444', File.stat(@name2).mode.to_s(8))
  end

  test "attempting to call chmod on a closed handle raises an error" do
    @file1.close
    assert_raise(IOError){ @file1.chmod(0644) }
  end

  test "chmod requires an argument" do
    assert_raises(ArgumentError){ @file1.chmod }
  end

  test "chmod requires an integer argument" do
    assert_raises(TypeError){ @file2.chmod(@file2) }
  end

  def teardown
    File.chmod(@mode1, @name1)
    File.chmod(@mode2, @name2)
    @file1.close if @file1 && !@file1.closed?
    @file2.close if @file2 && !@file2.closed?
    @name1 = nil
    @name2 = nil
    @mode1 = nil
    @mode2 = nil
  end
end
