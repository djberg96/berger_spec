######################################################################
# test_close.rb
#
# Test case for the Dir#close instance method
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Dir_Close_Instance < Test::Unit::TestCase
  include Test::Helper

  def setup
    @dirname = "bogus"
    system("mkdir #{@dirname}")
    @dir = Dir.new(@dirname)
  end

  test "close basic functionality" do
    assert_respond_to(@dir, :close)
    assert_nothing_raised{ @dir.close }
  end

  test "close returns nil" do
    assert_equal(nil, @dir.close)
  end

  test "calling close on a closed dir object raises an IO error" do
    assert_nothing_raised{ @dir.close }
    assert_raises(IOError){ @dir.close }
  end

  test "close does not accept any parameters" do
    assert_raises(ArgumentError){ @dir.close(1) }
  end

  def teardown
    @dir = nil
    remove_dir(@dirname)
  end
end
