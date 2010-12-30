########################################################################
# test_flock.rb
#
# Test case for the File#flock instance method.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_File_Flock_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @name  = 'test_flock_instance_method.txt'
    @file  = File.open(@name, 'w')
  end

  test "flock basic functionality" do
    assert_respond_to(@file, :flock)
  end

  # The second call causes Ruby to block on Windows. See RubyForge bug #18213.
  test "flock works with exclusive lock as expected" do
    assert_nothing_raised{ @file.flock(File::LOCK_EX) }
    omit_if(WINDOWS, "skipping part of exclusive flock test on MS Windows")
    assert_equal(0, @file.flock(File::LOCK_EX))
  end

  test "flock works with shared lock as expected" do
    assert_nothing_raised{ @value = @file.flock(File::LOCK_SH) }
    assert_equal(0, @file.flock(File::LOCK_SH))
  end

  test "flock works with unlocked lock as expected" do
    assert_nothing_raised{ @file.flock(File::LOCK_UN) }
    assert_equal(0, @file.flock(File::LOCK_UN))
  end

  # TODO: Create separate tests for an expected 0 and an expected false.
  test "flock works with exclusive nonblocking lock as expected" do
    flags = File::LOCK_EX | File::LOCK_NB
    assert_nothing_raised{ @file.flock(flags) }
    assert_true([0, false].include?(@file.flock(flags)))
  end

  def teardown
    @file.close unless @file.closed?
    File.delete(@name) if File.exists?(@name)

    @file  = nil
    @name  = nil
    @value = nil
  end
end
