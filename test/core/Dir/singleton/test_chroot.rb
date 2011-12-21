######################################################################
# test_chroot.rb
#
# Test case for the Dir.chroot class method.  Note that many tests
# are skipped on Windows and/or if the test suite is not being run
# as root.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Dir_Chroot_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @root = Dir.pwd
  end

  test "chroot basic functionality" do
    assert_respond_to(Dir, :chroot)
  end

  test "chroot sets the root of the current process to '/'" do
    omit_if(WINDOWS || JRUBY, "chroot test skipped on this platform")
    omit_unless(ROOT, "chroot test skipped if not run as root")
    assert_equal(0, Dir.chroot(@root))
    assert_equal("/", Dir.pwd)
  end

  test "chroot does not allow access to outside files once called" do
    omit_if(WINDOWS || JRUBY, "chroot test skipped on this platform")
    omit_unless(ROOT, "chroot test skipped if not run as root")
    assert_nothing_raised{ Dir.chroot(@root) }
    assert_raise(Errno::ENOENT){ Dir.chdir("/usr") }
  end

  test "chroot is permitted by a privileged process only" do
    omit_if(ROOT, "chroot test skipped if run as root")
    omit_if(WINDOWS || JRUBY, "chroot test skipped on this platform")
    assert_raise(Errno::EPERM){ Dir.chroot(@root) }
  end

  test "chroot accepts only string arguments" do
    omit_if(WINDOWS || JRUBY, "chroot test skipped on this platform")
    assert_raises(TypeError){ Dir.chroot(1) }
    assert_raises(TypeError){ Dir.chroot(true) }
  end

  test "chroot accepts only one argument" do
    omit_if(WINDOWS || JRUBY, "chroot test skipped on this platform")
    assert_raises(ArgumentError){ Dir.chroot(@root, @root) }
  end

  test "chroot is not implemented in Windows or JRuby" do
    omit_unless(WINDOWS || JRUBY, "chroot test skipped on this platform")
    assert_raise(NotImplementedError){ Dir.chroot(@root) }
  end

  def teardown
    @root = nil
  end
end
