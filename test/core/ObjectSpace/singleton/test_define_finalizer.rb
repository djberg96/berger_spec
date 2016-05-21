########################################################################
# test_define_finalizer.rb
#
# Test case for the ObjectSpace.define_finalizer.
#
# TODO: Figure out a way to fire off the finalizer and test the result
# without exiting the program.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_ObjectSpace_DefineFinalizer_SingletonMethod < Test::Unit::TestCase
  def setup
    @array  = [1,2,3]
    @hash   = {1 => 2, 3 => 4}
    @string = 'hello'
    @final  = nil
    @proc   = proc{ @final = 'test' }
  end

  test "define_finalizer basic functionality" do
    assert_respond_to(ObjectSpace, :define_finalizer)
  end

  test "define_finalizer with proc basic functionality" do
    assert_nothing_raised{ ObjectSpace.define_finalizer(@array, @proc) }
    assert_nil(@final)
  end

  test "define_finalizer with block basic functionality" do
    assert_nothing_raised{ ObjectSpace.define_finalizer(@hash){ @final = 'test2' } }
    assert_nil(@final)
  end

  test "define_finalizer with block and proc basic functionality" do
    assert_nothing_raised{ ObjectSpace.define_finalizer(@string, @proc){ @final = 'test3' } }
    assert_nil(@final)
  end

  test "define_finalizer requires valid arguments" do
    assert_raise(ArgumentError){ ObjectSpace.define_finalizer }
    assert_raise(ArgumentError){ ObjectSpace.define_finalizer(@array) }
    assert_raise(ArgumentError){ ObjectSpace.define_finalizer(@array, 7) }
    assert_raise(ArgumentError){ ObjectSpace.define_finalizer(@array, @proc, 7) }
  end

  def teardown
    @array = nil
    @hash  = nil
    @final = nil
    @proc  = nil
  end
end
