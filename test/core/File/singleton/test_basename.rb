##############################################################################
# test_basename.rb
#
# Test suite for the File.basename method. Note that there are some known
# issues with File.basename on MS Windows. See ruby-core: 10321.
##############################################################################
require 'test/helper'
require 'test/unit'

class TC_File_Basename_Class < Test::Unit::TestCase
  include Test::Helper

  def setup
    @path = WINDOWS ? "C:\\foo\\bar.txt" : "/foo/bar.txt"
  end

  test "basename basic functionality" do
    assert_respond_to(File, :basename)
    assert_nothing_raised{ File.basename("foo") }
    assert_kind_of(String, File.basename("foo"))
  end

  test "basename returns expected results for unix style paths" do
    assert_equal("bar", File.basename("/foo/bar"))
    assert_equal("bar.txt", File.basename("/foo/bar.txt"))
    assert_equal("bar.c", File.basename("bar.c"))
    assert_equal("bar", File.basename("/bar"))
    assert_equal("bar", File.basename("/bar/"))
  end

  test "basename handles multiple leading slashes as expected on unix" do
    omit_if(WINDOWS, "skipping basename with multiple leading slashes test on MS Windows")
    assert_equal("foo", File.basename("//foo"))
    assert_equal("baz", File.basename("//foo/bar/baz"))
  end

  test "basename with an empty string for an argument returns an empty string" do
    assert_equal("", File.basename(""))
  end

  test "basename with local relative path returns local relative path" do
    assert_equal(".", File.basename("."))
    assert_equal("..", File.basename(".."))
  end

  test "basename with leading and trailing slashes returns path without slashes" do
    omit_if(WINDOWS, "skipping basename with leading and trailing slashes test on MS Windows")
    assert_equal("foo", File.basename("//foo/"))
    assert_equal("foo", File.basename("//foo//"))
  end

  test "basename accepts a suffix" do
    assert_nothing_raised{ File.basename("test.txt", ".txt") }
  end

  test "basename with suffix returns expected results" do
    assert_equal("bar", File.basename("bar.c", ".c"))
    assert_equal("bar", File.basename("bar.txt", ".txt"))
    assert_equal("bar", File.basename("/bar.txt", ".txt"))
    assert_equal("bar", File.basename("/foo/bar.txt", ".txt"))
  end

  test "basename handles unmatched suffixes correctly" do
    assert_equal("bar.txt", File.basename("bar.txt", ".exe"))
  end

  test "basename handles name with multiple suffixes correctly" do
    assert_equal("bar.txt", File.basename("bar.txt.exe", ".exe"))
    assert_equal("bar.txt.exe", File.basename("bar.txt.exe", ".txt"))
    assert_equal("bar.jpg", File.basename("/foo/bar.jpg.txt", ".txt"))
    assert_equal("bar.jpg.txt", File.basename("/foo/bar.jpg.txt", ".jpg"))
    assert_equal("bar.jpg.txt", File.basename("/foo/bar.jpg.txt", ".xyz"))
  end

  test "basename accepts special star notation" do
    assert_nothing_raised{ File.basename("bar.txt", ".*") }
  end

  test "basename returns correct results when using special star notation" do
    assert_equal("bar", File.basename("bar.txt", ".*"))
    assert_equal("bar.txt", File.basename("bar.txt.exe", ".*"))
  end

  test "basename with an empty suffix is treated as if no argument were provided" do
    assert_equal("foo.txt", File.basename("/foo.txt", ""))
    assert_equal("", File.basename("", ""))
    assert_equal("foo.txt", File.basename("foo.txt   ", ""))
  end

  test "basename returns a tainted string if its argument is tainted" do
    assert_false(File.basename(@path).tainted?)
    assert_true(File.basename(@path.taint).tainted?)
  end

  test "the arguments to basename must be strings" do
    assert_raises(TypeError){ File.basename(nil) }
    assert_raises(TypeError){ File.basename(1) }
    assert_raises(TypeError){ File.basename("bar.txt", 1) }
    assert_raises(TypeError){ File.basename(true) }
  end

  test "basename accepts a maximum of two arguments" do
    assert_raises(ArgumentError){ File.basename('bar.txt', '.txt', '.txt') }
  end

  test "basename can handle windows style paths with forward slashes on any platform" do
    assert_equal("foo", File.basename("C:/foo"))
    assert_equal("bar", File.basename("C:/foo/bar"))
    assert_equal("bar", File.basename("C:/foo/bar/"))
    assert_equal("bar", File.basename("C:/foo/bar//"))
  end

  test "basename of a root path strips the drive letter on Windows" do
    omit_unless(WINDOWS)
    assert_equal("/", File.basename("C:/"))
    assert_equal("/", File.basename("D:/"))
    assert_equal("/", File.basename("//foo"))
    assert_equal("/", File.basename("//foo/bar"))
  end

  test "basename returns expected results for standard Windows style paths" do
    omit_unless(WINDOWS, "basename tests for Windows style paths skipped except on Windows")
    assert_equal("baz.txt", File.basename("C:\\foo\\bar\\baz.txt"))
    assert_equal("bar", File.basename("C:\\foo\\bar"))
    assert_equal("bar", File.basename("C:\\foo\\bar\\"))
    assert_equal("foo", File.basename("C:\\foo"))
  end

  test "basename returns expected results for Windows UNC paths" do
    omit_unless(WINDOWS, "basename tests for Windows style paths skipped except on Windows")
    assert_equal("baz.txt", File.basename("\\\\foo\\bar\\baz.txt"))
    assert_equal("baz", File.basename("\\\\foo\\bar\\baz"))
  end

  test "basename returns expected results for Windows style paths with a suffix" do
    omit_unless(WINDOWS, "basename tests for Windows style paths skipped except on Windows")
    assert_equal("bar", File.basename("c:\\bar.txt", ".txt"))
    assert_equal("bar", File.basename("c:\\foo\\bar.txt", ".txt"))
    assert_equal("bar.txt", File.basename("c:\\bar.txt", ".exe"))
    assert_equal("bar.txt", File.basename("c:\\bar.txt.exe", ".exe"))
    assert_equal("bar.txt.exe", File.basename("c:\\bar.txt.exe", ".txt"))
    assert_equal("bar", File.basename("c:\\bar.txt", ".*"))
    assert_equal("bar.txt", File.basename("c:\\bar.txt.exe", ".*"))
  end

  def teardown
    @path = nil
  end
end
