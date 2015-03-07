###############################################################################
# test_split.rb
#
# Test suite for the File.split class method.
#
# Note: this author considers the behavior of File.split on root paths to
# be nonsensical. The POSIX spec does NOT back up the current implementation.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_File_Split_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @path = "/foo/bar/baz.rb"
  end

  test "split works as expected on UNC paths" do
    omit_unless(WINDOWS)
    assert_equal(['//foo/bar', 'baz'], File.split("//foo/bar/baz"))
    assert_equal(['//foo/bar', 'baz'], File.split("//foo/bar/baz/"))
    assert_equal(['//foo/bar', '/'], File.split("//foo/bar"))
    assert_equal(['//foo/bar', '/'], File.split("//foo/bar/"))
    assert_equal(['//foo', '/'], File.split("//foo"))
    assert_equal(['//foo', '/'], File.split("//foo/"))
  end

  test "split works as expected on root windows paths" do
    omit_unless(WINDOWS)
    assert_equal(["C:/", '/'], File.split("C:/"))
    assert_equal(["C:\\", '\\'], File.split("C:\\"))
    assert_equal(['C:/foo/bar', 'baz'], File.split("C:/foo/bar/baz"))
    assert_equal(["C:\\foo\\bar", "baz"], File.split("C:\\foo\\bar\\baz"))
  end

  test "split ignores leading slashes" do
    omit_unless(WINDOWS)
    assert_equal(['//foo', '/'], File.split('//////foo'))
    assert_equal(['//foo', '/'], File.split('//////foo///'))
    assert_equal(['//foo', 'bar'], File.split('//////foo//bar'))
  end

  test "split basic functionality" do
    assert_respond_to(File, :split)
    assert_nothing_raised{ File.split(@path) }
    assert_kind_of(Array, File.split(@path))
  end

  test "split returns expected results for simple paths" do
    assert_equal(['.', 'foo'], File.split('foo'))
    assert_equal(['foo', 'bar'], File.split('foo/bar'))
    assert_equal(['/foo', 'bar'], File.split('/foo/bar'))
    assert_equal(['/foo', 'bar'], File.split('/foo/bar/'))
  end

  test "split returns expected results for files with extensions" do
    assert_equal(['/foo/bar', 'baz.rb'], File.split(@path))
    assert_equal(['.', 'baz.rb'], File.split('baz.rb'))
    assert_equal(['/', 'baz.rb'], File.split('/baz.rb'))
  end

  test "split returns an untainted array, but its elements are tainted" do
    assert_false(File.split(@path).tainted?)
    assert_nothing_raised{ @path.taint }
    assert_false(File.split(@path).tainted?)
    assert_true(File.split(@path)[0].tainted?)
  end

  test "split ignores extra slashes on unix style paths" do
    omit_if(WINDOWS)
    assert_equal(['/', '/'], File.split('/')) # POSIX? Maybe.
    assert_equal(['/', 'foo'], File.split('//////foo'))
    assert_equal(['/', 'foo'], File.split('//////foo///'))
    assert_equal(['/foo', 'bar'], File.split('/foo/bar////'))
  end

  test "split returns expected result for empty string" do
    assert_equal(['.', ''], File.split(''))
  end

  test "split returns expected result for '.' path" do
    assert_equal(['.', '.'], File.split('.'))
  end

  test "split returns expected result for whitespace" do
    omit_if(WINDOWS)
    assert_equal(['.', ' '], File.split(' '))
  end

  test "split requires a single argument" do
    assert_raise(ArgumentError){ File.split }
    assert_raise(ArgumentError){ File.split('foo', 'bar') }
  end

  test "split requires a string argument" do
    assert_raise(TypeError){ File.split(1) }
    assert_raise(TypeError){ File.split(nil) }
  end

  def teardown
    @path = nil
  end
end
