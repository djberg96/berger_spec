###########################################
# test_dirname.rb
#
# Test suite for the File.dirname method.
###########################################
require 'test/helper'
require 'test-unit'

class TC_File_Dirname_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @path = WINDOWS ? "C:\\foo\\bar.txt" : "/foo/bar.txt"
  end

  test "dirname basic functionality" do
    assert_respond_to(File, :dirname)
    assert_nothing_raised{ File.dirname("foo") }
    assert_kind_of(String, File.dirname("foo"))
  end

  test "dirname on unix style paths returns the expected result" do
    assert_equal(".", File.dirname("foo"))
    assert_equal("/", File.dirname("/foo"))
    assert_equal("/foo", File.dirname("/foo/bar"))
    assert_equal("/foo", File.dirname("/foo/bar.txt"))
    assert_equal("/foo/bar", File.dirname("/foo/bar/baz"))
    assert_equal(".", File.dirname("./foo"))
    assert_equal("./foo", File.dirname("./foo/bar"))
  end

  test "dirname on '.', '..' or an empty string returns '.'" do
    assert_equal(".", File.dirname(""))
    assert_equal(".", File.dirname("."))
    assert_equal(".", File.dirname(".."))
  end

  test "dirname returns root path when expected to" do
    assert_equal("/", File.dirname("/"))
    assert_equal("/", File.dirname("/foo/"))
  end

  test "dirname with multiple leading or trailing slashes returns the expected result" do
    assert_equal("/", File.dirname("//foo"))
    assert_equal("/", File.dirname("//foo//"))
  end

  test "dirname returns a tainted string if its argument is tainted" do
    assert_false(File.dirname(@path).tainted?)
    assert_nothing_raised{ @path.taint }
    assert_true(File.dirname(@path).tainted?)
  end

  test "dirname requires a string argument" do
    assert_raises(TypeError){ File.dirname(nil) }
    assert_raises(TypeError){ File.dirname(0) }
    assert_raises(TypeError){ File.dirname(true) }
    assert_raises(TypeError){ File.dirname(false) }
  end

  # Windows specific tests
  if WINDOWS
    test "dirname handles windows paths with forward slashes" do
      assert_equal("C:/", File.dirname("C:/"))
      assert_equal("C:/", File.dirname("C:/foo"))
      assert_equal("C:/foo", File.dirname("C:/foo/bar"))
      assert_equal("C:/foo", File.dirname("C:/foo/bar/"))
      assert_equal("C:/foo", File.dirname("C:/foo/bar//"))
    end

    test "dirname handles windows paths with backslashes" do
      assert_equal("C:\\foo\\bar", File.dirname("C:\\foo\\bar\\baz.txt"))
      assert_equal("C:\\foo", File.dirname("C:\\foo\\bar"))
      assert_equal("C:\\foo", File.dirname("C:\\foo\\bar\\"))
      assert_equal("C:\\", File.dirname("C:\\foo"))
      assert_equal("C:\\", File.dirname("C:\\"))
    end

    test "dirname handles UNC paths properly" do
      assert_equal("\\\\foo\\bar", File.dirname("\\\\foo\\bar\\baz.txt"))
      assert_equal("\\\\foo\\bar", File.dirname("\\\\foo\\bar\\baz"))
      assert_equal("\\\\foo", File.dirname("\\\\foo"))
      assert_equal("\\\\foo\\bar", File.dirname("\\\\foo\\bar"))
    end
  end

  def teardown
    @path = nil
  end
end
