#####################################################################
# test_expand_path.rb
#
# Test case for the File.expand_path class method.
#####################################################################
require 'test/helper'
require 'test-unit'

class TC_File_ExpandPath_SingletonMethod < Test::Unit::TestCase
  extend Test::Helper
  include Test::Helper

  def self.startup
    @@user = get_user
    @@home = get_home
  end

  def setup
    @pwd  = Dir.pwd
    ENV['HOME'] = ENV['USERPROFILE'] if WINDOWS
  end

  test "expand_path basic functionality" do
    assert_respond_to(File, :expand_path)
    assert_nothing_raised{ File.expand_path(__FILE__) }
    assert_kind_of(String, File.expand_path(__FILE__))
  end

  # On MS Windows it appears that the home drive is automatically prepended
  # to the path if no path is provided.
  test "expand_path returns the expected result for '.' and '..'" do
    assert_equal(@pwd, File.expand_path('.'))
    assert_equal(File.dirname(@pwd), File.expand_path('..'))
    assert_equal(File.dirname(File.dirname(@pwd)), File.expand_path('../..'))
  end

  test "expand_path returns the original path if it is an absolute path" do
    if WINDOWS
      assert_equal('C:/', File.expand_path('/'))
      assert_equal('C:/', File.expand_path('C:/'))
      assert_equal('C:/bin', File.expand_path('/bin'))
      assert_equal('C:/foo/bar', File.expand_path('C:/foo/bar'))
    else
      assert_equal('/', File.expand_path('/'))
      assert_equal("/bin", File.expand_path("/bin"))
      assert_equal('/foo/bar', File.expand_path('/foo/bar'))
    end
  end

  test "expand_path returns the original path if it is a UNC path" do
    omit_unless(WINDOWS)
    assert_equal('//', File.expand_path('//'))
    assert_equal('//foo', File.expand_path('//foo'))
    assert_equal('//foo/bar', File.expand_path('//foo/bar'))
    assert_equal('//foo/bar/baz', File.expand_path('//foo/bar/baz'))
  end

  test "expand_path collapses ellipsis as expected" do
    if WINDOWS
      assert_equal('C:/bar', File.expand_path('/foo/../bar'))
      assert_equal('C:/bar', File.expand_path('/../../bar'))
      assert_equal('C:/', File.expand_path('/../../bar/..'))
    else
      assert_equal('/bar', File.expand_path('/foo/../bar'))
      assert_equal('/bar', File.expand_path('/../../bar'))
      assert_equal('/', File.expand_path('/../../bar/..'))
    end
  end

  test "expand_path with dir argument returns expected result" do
    if WINDOWS
      assert_equal("C:/bin", File.expand_path("../../bin", "C:/tmp/x"))
      assert_equal("C:/bin", File.expand_path("../../bin", "C:/tmp"))
      assert_equal("C:/bin", File.expand_path("../../bin", "C:/"))
      assert_equal(File.join(@pwd, 'bin'), File.expand_path("../../bin", "tmp/x"))
      assert_equal(File.join(@pwd, 'tmp/x/y/bin'), File.expand_path("../bin", "tmp/x/y/z"))
    else
      assert_equal("/bin", File.expand_path("../../bin", "/tmp/x"))
      assert_equal("/bin", File.expand_path("../../bin", "/tmp"))
      assert_equal("/bin", File.expand_path("../../bin", "/"))
      assert_equal("/bin", File.expand_path("../../../../../../../bin", "/"))
      assert_equal(File.join(@pwd, 'bin'), File.expand_path("../../bin", "tmp/x"))
      assert_equal(File.join(@pwd, 'tmp/x/y/bin'), File.expand_path("../bin", "tmp/x/y/z"))
    end
  end

  test "expand_path with tilde and user name returns user's home directory" do
    omit_if(WINDOWS)
    assert_equal(@@home, File.expand_path("~#{@@user}"))
    assert_equal(File.join(@@home, 'bin'), File.expand_path("~#{@@user}/bin"))
  end

  # Second argument ignored if tilde is present and it's at position 0.
  test "expand_path with tilde, user name and directory argument returns expected result" do
    omit_if(WINDOWS)
    assert_equal(@@home, File.expand_path("~#{@@user}", '.'))
    assert_equal(@@home, File.expand_path("~#{@@user}", '..'))
    assert_equal(@@home, File.expand_path("~#{@@user}", '/tmp'))
    assert_equal(@@home, File.expand_path("~#{@@user}", '../tmp'))
    assert_equal(File.join(@@home, 'bin'), File.expand_path("~#{@@user}/bin", '/tmp'))
  end

  test "expand_path requires a string argument" do
    assert_raises(ArgumentError){ File.expand_path }
    assert_raises(TypeError){ File.expand_path(1) }
    assert_raises(TypeError){ File.expand_path(nil) }
    assert_raises(TypeError){ File.expand_path(true) }
  end

  test "expand_path with tilde raises an error if the user is not found" do
    omit_if(WINDOWS)
    assert_raises(ArgumentError){ File.expand_path("~bogus") }
  end

  def teardown
    @pwd  = nil
    @user = nil
    @home = nil
  end

  def self.shutdown
    @@user = nil
    @@home = nil
  end
end
