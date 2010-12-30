##########################################################
# test_join.rb
#
# Test suite for the File.join class method
##########################################################
require "test/helper"
require "test/unit"

class TC_File_Join_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @root = get_root_path()
    @dirs = ['usr', 'local', 'bin']
  end

  test "join basic functionality" do
    assert_respond_to(File, :join)
    assert_nothing_raised{ File.join("usr", "local", "bin") }
    assert_kind_of(String, File.join("usr", "local", "bin"))
  end

  test "join with an empty string returns an empty string" do
    assert_equal("", File.join(""))
  end

  test "join with an empty string as first argument creates absolute path" do
    assert_equal("/foo", File.join("", "foo"))
  end

  test "join retains unc path in the first position" do
    omit_unless(WINDOWS, "join path with unc root test skipped except on MS Windows")
    assert_equal("\\\\usr/local", File.join("\\\\", "usr", "local"))
  end

  test "join retains multiple slashes in the first position" do
    assert_equal("////foo/bar", File.join("////", "foo", "bar"))
  end

  test "join does not compact slashes" do
    assert_equal("foo//bar///baz", File.join("foo", "//bar", "///baz"))
  end

  test "join ignores empty strings not in the first position" do
    assert_equal("usr/local/bin", File.join("usr", "", "local", "", "bin"))
  end

  test "join on windows returns the expected result" do
    omit_unless(WINDOWS, "join test skipped except on MS Windows")
    assert_equal("usr/local/bin", File.join(*@dirs))
    assert_equal("C:\\usr/local/bin", File.join(@root, *@dirs))
  end

  test "join on unix returns the expected results" do
    omit_if(WINDOWS, "join test skipped on MS Windows")
    assert_equal("usr/local/bin", File.join(*@dirs))
    assert_equal("/usr/local/bin", File.join(@root, *@dirs))
  end

  test "join returns a tainted string if any argument is tainted" do
    assert_false(File.join("test1", "test2").tainted?)
    assert_true(File.join(Dir.pwd, "test1").tainted?) # Dir.pwd tainted
  end

  test "arguments to join must be strings" do
    assert_raises(TypeError){ File.join(true, false) }
    assert_raises(TypeError){ File.join(nil, nil) }
  end

  def teardown
    @root = nil
    @dirs = nil
  end
end
