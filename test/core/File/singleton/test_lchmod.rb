#####################################################################
# test_lchmod.rb
#
# Test case for the File.lchmod singleton method.
#####################################################################
require 'mkmf/lite'
require 'test/helper'
require 'test/unit'

class TC_File_Lchmod_SingletonMethod < Test::Unit::TestCase
  include Test::Helper
  extend Mkmf::Lite

  def self.startup
    @@lchmod_support = have_func('lchmod')
    @@lchmod_message = "lchmod not supported on this platform"
  end

  def setup
    @file1 = File.expand_path(__FILE__)
    @file2 = base_file(__FILE__, 'test_atime.rb')
    @file1_mode = File.stat(@file1).mode
    @file2_mode = File.stat(@file2).mode
  end

  test "lchmod basic functionality" do
    omit_unless(@@lchmod_support, @@lchmod_message)
    assert_respond_to(File, :lchmod)
    assert_nothing_raised{ File.lchmod(0644, @file1) }
    assert_kind_of(Fixnum, File.lchmod(0644, @file1))
  end

  test "lchmod can be called on multiple files" do
    omit_unless(@@lchmod_support, @@lchmod_message)
    assert_nothing_raised{ File.lchmod(0644, @file1, @file2) }
    assert_equal('100644', File.stat(@file1).mode.to_s(8))
    assert_equal('100644', File.stat(@file2).mode.to_s(8))
  end

  test "lchmod returns the number of files modified" do
    omit_unless(@@lchmod_support, @@lchmod_message)
    assert_equal(1, File.lchmod(0644, @file1))
    assert_equal(2, File.lchmod(0644, @file1, @file2))
  end

  test "lchmod sets the permissions as expected" do
    omit_unless(@@lchmod_support, @@lchmod_message)
    assert_nothing_raised{ File.lchmod(0644, @file1) }
    assert_equal('100644', File.stat(@file1).mode.to_s(8))
    assert_nothing_raised{ File.lchmod(0444, @file2) }
    assert_equal('100444', File.stat(@file2).mode.to_s(8))
  end

  test "lchmod does not actually require any file arguments" do
    omit_unless(@@lchmod_support, @@lchmod_message)
    notify("File.lchmod with no files should probably be an ArgumentError")
    assert_nothing_raised{ File.lchmod(0444) }
    assert_equal(0, File.lchmod(0444))
  end

  test "lchmod requires at least one argument" do
    omit_unless(@@lchmod_support, @@lchmod_message)
    assert_raises(ArgumentError){ File.lchmod }
  end

  test "the first argument to lchmod must be numeric" do
    omit_unless(@@lchmod_support, @@lchmod_message)
    assert_raises(TypeError){ File.lchmod('0644') }
  end

  def teardown
    if @@lchmod_support
      File.lchmod(@file1_mode, @file1)
      File.lchmod(@file2_mode, @file2)
    end
    @file1 = nil
    @file2 = nil
    @file1_mode = nil
    @file2_mode = nil
  end

  def self.shutdown
    @@lchmod_support = nil
    @@lchmod_message = nil
  end
end
