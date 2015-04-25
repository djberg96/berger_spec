########################################################################
# test_global_variables.rb
#
# Test case for the Kernel.global_variables module method.
########################################################################
require 'test/unit'

class TC_Kerel_GlobalVariables_ModuleMethod < Test::Unit::TestCase
  test "global_variables basic functionality" do
    assert_respond_to(Kernel, :global_variables)
    assert_nothing_raised{ Kernel.global_variables }
    assert_kind_of(Array, Kernel.global_variables)
  end

  test '$! is included in global_variables' do
    assert_true(Kernel.global_variables.include?(:$!))
  end

  test '$" is included in global_variables' do
    assert_true(Kernel.global_variables.include?(:$"))
  end

  test '$$ is included in global_variables' do
    assert_true(Kernel.global_variables.include?(:$$))
  end

  test '$& is included in global_variables' do
    assert_true(Kernel.global_variables.include?(:$&))
  end

  test "$' is included in global_variables" do
    assert_true(Kernel.global_variables.include?(:$'))
  end

  test "$* is included in global_variables" do
    assert_true(Kernel.global_variables.include?(:$*))
  end

  test "$+ is included in global_variables" do
    assert_true(Kernel.global_variables.include?(:$+))
  end

  test "$, is included in global_variables" do
    assert_true(Kernel.global_variables.include?(:$,))
  end

  test "$-0 is included in global_variables" do
    assert_true(Kernel.global_variables.include?(:$-0))
  end

  test "$-F is included in global_variables" do
    assert_true(Kernel.global_variables.include?(:$-F))
  end

  test "$-I is included in global_variables" do
    assert_true(Kernel.global_variables.include?(:$-I))
  end

  test "$LOAD_PATH is included in global_variables" do
    assert_true(Kernel.global_variables.include?(:$LOAD_PATH))
  end

  test "$SAFE is included in global_variables" do
    assert_true(Kernel.global_variables.include?(:$SAFE))
  end

  test "the global_variables method does not take an argument" do
    assert_raise(ArgumentError){ Kernel.global_variables(true) }
  end
end
