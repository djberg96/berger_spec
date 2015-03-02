######################################################################
# test_link.rb
#
# Test case for the File.link class method. Most tests skipped on
# MS Windows
######################################################################
require 'test/helper'
require 'test-unit'

class TC_File_Link_ClassMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @file = File.expand_path(File.dirname(__FILE__)) + "/test.txt"
    @link = File.expand_path(File.dirname(__FILE__)) + "/test.lnk"
    touch(@file)
  end

  test "link basic functionality" do
    assert_respond_to(File, :link)
    assert_nothing_raised{ File.link(@file, @link) }
  end

  test "link method creates link and returns zero on success" do
    assert_equal(0, File.link(@file, @link))
    assert_true(File.exist?(@link))
  end

  test "link method raises an error if link already exists" do
    File.link(@file, @link)
    assert_raises(Errno::EEXIST){ File.link(@file, @link) }
  end

  test "link method requires two arguments" do
    assert_raises(ArgumentError){ File.link }
    assert_raises(ArgumentError){ File.link(@file) }
  end

  test "arguments to link method must be strings" do
    assert_raises(TypeError){ File.link(@file, 1) }
    assert_raises(TypeError){ File.link(1, @file) }
  end

  def teardown
    remove_file(@link) if File.exist?(@link)
    remove_file(@file) if File.exist?(@file)
    @link = nil
    @file = nil
  end
end
