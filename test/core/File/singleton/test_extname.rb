###########################################
# test_extname.rb
#
# Test suite for the File.extname method.
###########################################
require 'test/helper'
require 'test-unit'

class TC_File_Extname_SingletonMethod < Test::Unit::TestCase
  def setup
    @file = "foo.rb"
  end

  test "extname basic functionality" do
    assert_respond_to(File, :extname)
    assert_nothing_raised{ File.extname("foo.rb") }
    assert_kind_of(String, File.extname("foo.rb"))
  end

  test "extname returns expected result on unix style absolute paths with extension" do
    assert_equal(".rb", File.extname("/foo/bar.rb"))
    assert_equal(".c", File.extname("/foo.rb/bar.c"))
  end

  test "extname returns expected result on unix style absolute paths without extension" do
    assert_equal("", File.extname("/foo.bar/baz"))
  end

  test "extname returns expected result for relative paths with extension" do
    assert_equal(".rb", File.extname("foo.rb"))
    assert_equal(".conf", File.extname(".app.conf"))
    assert_equal("", File.extname(".bashrc"))
  end

  test "extname returns expected result for relative paths without extension" do
    assert_equal("", File.extname("bar"))
    assert_equal("", File.extname("foo-bar"))
  end

  test "extname returns tainted string if argument is tainted" do
    assert_false(File.extname(@file).tainted?)
    assert_nothing_raised{ @file.taint }
    assert_true(File.extname(@file).tainted?)
  end

  test "extname returns empty string for empty or unusual arguments" do
    assert_equal("", File.extname(""))
    assert_equal("", File.extname("."))
    assert_equal("", File.extname("/"))
    assert_equal("", File.extname("/."))
    assert_equal("", File.extname(".."))
    assert_equal("", File.extname(".foo."))
    assert_equal("", File.extname("foo."))
  end

  test "extname requires a string argument" do
    assert_raises(TypeError){ File.extname(nil) }
    assert_raises(TypeError){ File.extname(0) }
    assert_raises(TypeError){ File.extname(true) }
    assert_raises(TypeError){ File.extname(false) }
  end

  test "extnamee only takes one argument" do
    assert_raises(ArgumentError){ File.extname("foo.bar", "foo.baz") }
  end

  def teardown
    @file = nil
  end
end
