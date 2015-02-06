#########################################################
# test_fileno.rb
#
# Test suite for the Dir#fileno instance method.
#########################################################
require 'test/helper'
require 'test-unit'

class TC_Dir_Fileno_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @dir = Dir.new(Dir.pwd)
  end

  test "fileno basic functionality" do
    omit_unless(LINUX)
    assert_respond_to(@dir, :fileno)
    assert_nothing_raised{ @dir.fileno }
    assert_kind_of(Numeric, @dir.fileno)
  end

  test "fileno returns expected results" do
    omit_unless(LINUX)
    assert_true(@dir.fileno > 0)
  end

  test "fileno does not accept any parameters" do
    omit_unless(LINUX)
    assert_raises(ArgumentError){ @dir.fileno('foo') }
  end

  def teardown
    @dir.close
    @dir = nil
  end
end
