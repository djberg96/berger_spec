########################################################################
# test_tmpdir.rb
#
# Test case for the tmpdir library.
########################################################################
require 'test-unit'
require 'test/helper'
require 'tmpdir'

class Test_Tmpdir_Stdlib < Test::Unit::TestCase
  include Test::Helper

  # Helper method used to unset the environment variables in order to
  # validate the behavior when these cannot be found by the library.
  def remove_env_tmpdirs
    ENV['TMPDIR'] = nil
    ENV['TMP'] = nil
    ENV['TEMP'] = nil
    ENV['USERPROFILE'] = nil
  end

  # Restore any environment variables we may have unset
  def restore_env_tmpdirs
    ENV['TMPDIR'] = @env_tmpdir
    ENV['TMP'] = @env_tmp
    ENV['TEMP'] = @env_temp
    ENV['USERPROFILE'] = @env_userprofile
  end

  def setup
    @tmp  = get_temp_path
    @dtmp = File.join(Dir.pwd, 'mytemp')
    @ftmp = 'tmpdir.tmp'

    @env_tmpdir = ENV['TMPDIR']
    @env_tmp = ENV['TMP']
    @env_temp = ENV['TEMP']
    @env_userprofile = ENV['USERPROFILE']

    Dir.mkdir(@dtmp) unless File.exist?(@dtmp)
  end

  test "tmpdir basic functionality" do
    assert_respond_to(Dir, :tmpdir)
    assert_nothing_raised{ Dir.tmpdir }
  end

  test "tmpdir returns a string" do
    assert_kind_of(String, Dir.tmpdir)
    assert_true(Dir.tmpdir.size > 0)
  end

  test "tmpdir exists on the filesystem" do
    assert_true(File.exist?(Dir.tmpdir))
  end

  test "tmpdir returns the expected result" do
    assert_equal(File.expand_path(@tmp), Dir.tmpdir)
  end

  test "tmpdir uses ENV['TMPDIR'] as it's first check by default" do
    remove_env_tmpdirs
    ENV['TMPDIR'] = @dtmp
    assert_equal(Dir.tmpdir, @dtmp)
  end

  test "tmpdir uses ENV['TMP'] as it's second check by default" do
    remove_env_tmpdirs
    ENV['TMP'] = Dir.pwd
    assert_equal(Dir.tmpdir, Dir.pwd)
  end

  test "tmpdir uses ENV['TEMP'] as it's third check by default" do
    remove_env_tmpdirs
    ENV['TEMP'] = @dtmp
    assert_equal(Dir.tmpdir, @dtmp)
  end

  test "tmpdir resorts to a specific directory if none of the relevant ENV variables are found" do
    remove_env_tmpdirs
    assert_equal(File.expand_path(Etc.systmpdir), Dir.tmpdir)
  end

  test "tmpdir defaults to the systmpdir if the tmpdir exists but is not writable" do
    remove_env_tmpdirs
    File.chmod(0444, @dtmp)
    ENV['TMPDIR'] = @dtmp
    assert_equal(File.expand_path(Etc.systmpdir), Dir.tmpdir)
  end

  test "tmpdir defaults to the systmpdir if the tmpdir exists but is not a directory" do
    remove_env_tmpdirs
    touch(@ftmp)
    ENV['TMPDIR'] = @ftmp
    assert_equal(File.expand_path(Etc.systmpdir), Dir.tmpdir)
  end

  test "tmpdir defaults to the systmpdir if the tmpdir exists but is world writable" do
    omit_if(WINDOWS)
    remove_env_tmpdirs
    File.chmod(0777, @dtmp)
    ENV['TMPDIR'] = @dtmp
    assert_equal(File.expand_path(Etc.systmpdir), Dir.tmpdir)
  end

  test "tmpdir defaults to the systmpdir if the tmpdir exists but is sticky" do
    omit_if(WINDOWS)
    remove_env_tmpdirs
    File.chmod(10770, @dtmp)
    ENV['TMPDIR'] = @dtmp
    assert_equal(File.expand_path(Etc.systmpdir), Dir.tmpdir)
  end

  test "tmpdir defaults to systmpdir if $SAFE level is greater than zero" do
    remove_env_tmpdirs
    proc do
      $SAFE = 1
      assert_equal(Etc.systmpdir, Dir.tmpdir)
    end.call
  end

  test "mktmpdir basic functionality" do
    assert_respond_to(Dir, :mktmpdir)
  end

  def teardown
    FileUtils.rm_rf(@dtmp) if File.exist?(@dtmp)
    File.delete(@ftmp) if File.exist?(@ftmp)
    restore_env_tmpdirs
    @tmp  = nil
    @dtmp = nil
    @ftmp = nil
  end
end
