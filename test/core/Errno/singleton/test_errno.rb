###############################################################################
# test_errno.rb
#
# Test case for the Errno module. The tests here are rather generic because
# it is impossible to predict which Errno classes will exist on any given
# operating system.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_Errno_Module < Test::Unit::TestCase
  test "Errno is a module" do
    assert_kind_of(Module, Errno.class)
  end

  test "Errno contains a list of subclasses" do
    assert_respond_to(Errno, :constants)
    assert_kind_of(Array, Errno.constants)
  end

  test "Errno classes are a subclass of SystemCallError" do
    assert_kind_of(SystemCallError, Errno::EINVAL.new)
    assert_kind_of(SystemCallError, Errno::EACCES.new)
  end

  test "Errno class constants are operating system error numbers" do
    assert_kind_of(Fixnum, Errno::EINVAL::Errno)
    assert_kind_of(Fixnum, Errno::EACCES::Errno)
  end
end
