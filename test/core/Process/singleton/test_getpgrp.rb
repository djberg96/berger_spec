######################################################################
# test_getpgrp.rb
#
# Test case for the Process.getpgrp module method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Process_Getpgrp_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  test "getpgrp basic functionality" do
    assert_respond_to(Process, :getpgrp)
    assert_nothing_raised{ Process.getpgrp }
    assert_kind_of(Fixnum, Process.getpgrp)
  end

  test "getpgrp returns expected results" do
    assert_true(Process.getpgrp > 0)
    assert_equal(Process.getpgrp, Process.getpgid(0))
  end

  test "getpgrp does not accept any arguments" do
    assert_raise(ArgumentError){ Process.getpgrp(1) }
  end
end
