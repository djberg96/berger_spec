########################################################################
# test_isatty.rb
#
# Test case for the IO#isatty instance method and the IO#tty? alias.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_IO_Isatty_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @null = null_device
    @file = File.expand_path(File.basename(__FILE__, '.rb')) + '.txt'
    @fh   = File.open(@file, 'wb')
    @nh   = File.open(@null)

    unless WINDOWS
      @tty  = '/dev/tty'
      @th = File.new(@tty) if File.exists?(@tty)
    end
  end

  test "isatty basic functionality" do
    assert_respond_to(@fh, :isatty)
    assert_nothing_raised{ @fh.isatty }
    assert_boolean(@fh.isatty)
  end

  test "tty is an alias for isatty" do
    assert_alias_method(@fh, :tty?, :isatty)
  end

  test "isatty returns expected results" do
    assert_false(@fh.isatty)

    if WINDOWS
      assert_true(@nh.isatty)
    else
      assert_false(@nh.isatty)
      assert_true(@th.isatty) if @th
    end
  end

  # I'm assuming you don't run your test cases via cron...
  test "isatty returns true for STDOUT" do
    notify("This may be incorrect. See http://tinyurl.com/248kem9") if WINDOWS
    assert_true(STDOUT.isatty)
  end

  test "isatty does not accept any arguments" do
    assert_raise(ArgumentError){ @fh.isatty(1) }
  end

  def teardown
    @fh.close unless @fh.closed?
    @nh.close unless @nh.closed?
    @th.close if @th && !@th.closed? unless WINDOWS

    remove_file(@file)

    @null = nil
    @file = nil
    @tty  = nil
  end
end
