#####################################################################
# test_constants.rb
#
# Test case that verifies that certain constants within the File
# class are defined and, in some cases, their values.
#
# Note that there is some overlap between this test case and the
# equivalent test case for IO.
#####################################################################
require 'test/helper'
require 'test-unit'

class TC_File_Constants < Test::Unit::TestCase
  include Test::Helper

  test "match mode constants are defined" do
    assert_not_nil(File::FNM_NOESCAPE)
    assert_not_nil(File::FNM_PATHNAME)
    assert_not_nil(File::FNM_DOTMATCH)
    assert_not_nil(File::FNM_CASEFOLD)
    assert_not_nil(File::FNM_SYSCASE)
  end

  test "windows and vms define FNM_SYSCASE" do
    omit_unless(WINDOWS)
    assert_equal(8, File::FNM_SYSCASE)
  end

  test "path separator constants are defined" do
    assert_not_nil(File::SEPARATOR)
    assert_not_nil(File::Separator)
    assert_not_nil(File::PATH_SEPARATOR)
    assert_equal("/", File::SEPARATOR)
  end

  test "ALT_SEPARATOR is defined on windows and vms" do
    omit_unless(WINDOWS || VMS)
    assert_not_nil(File::ALT_SEPARATOR)
  end

  test "ALT_SEPARATOR is not defined on unixy platforms" do
    omit_if(WINDOWS || VMS)
    assert_nil(File::ALT_SEPARATOR)
  end

  test "PATH_SEPARATOR returns expected value on windows" do
    omit_unless(WINDOWS || VMS)
    assert_equal(";", File::PATH_SEPARATOR)
  end

  test "PATH_SEPARATOR returns expected value on non-windows platforms" do
    omit_if(WINDOWS || VMS)
    assert_equal(":", File::PATH_SEPARATOR)
  end

  test "open mode constants are defined" do
    assert_not_nil(File::APPEND)
    assert_not_nil(File::CREAT)
    assert_not_nil(File::EXCL)
    assert_not_nil(File::NONBLOCK)
    assert_not_nil(File::RDONLY)
    assert_not_nil(File::RDWR)
    assert_not_nil(File::TRUNC)
    assert_not_nil(File::WRONLY)
  end

  test "open mode NOCTTY is defined on windows" do
    omit_unless(WINDOWS)
    assert_not_nil(File::NOCTTY)
  end

  test "lock mode constants are defined" do
    assert_not_nil(File::LOCK_EX)
    assert_not_nil(File::LOCK_NB)
    assert_not_nil(File::LOCK_SH)
    assert_not_nil(File::LOCK_UN)
  end
end
