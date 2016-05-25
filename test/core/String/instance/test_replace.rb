######################################################################
# test_replace.rb
#
# Test case for the String#replace instance method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_String_Replace_InstanceMethod < Test::Unit::TestCase
  include Test::Helper
   
  def setup
    @string1 = '<html><b>hello</b></html>'
    @string2 = @string1
  end

  test "replace basic functionality" do
    assert_respond_to(@string1, :replace)
    assert_nothing_raised{ @string1.replace("") }
  end

  test "replace returns expected value" do
    assert_equal("x,y,z", @string1.replace("x,y,z"))
  end

  test "replace modifies its receiver" do
    @string1.replace("x,y,z")
    assert_equal("x,y,z", @string1)
  end

  test "replace modifies any referent" do
    @string1.replace("x,y,z")
    assert_equal(@string2, @string1)
    assert_equal(@string2.object_id, @string1.object_id)
  end
 
  test "replacing a string with itself is legal" do
    assert_nothing_raised{ @string1.replace(@string1) }
    assert_equal('<html><b>hello</b></html>', @string1)
  end

  test "replacing a string with itself is effectively a no-op" do
    assert_equal(@string1.object_id, @string1.replace(@string1).object_id)
  end

  test "replacing a string with a tainted string makes it tainted" do
    assert_false(@string1.replace('world').tainted?)
    assert_true(@string1.replace('world'.taint).tainted?)
  end
   
  test "attempting a replace a string in $SAFE mode 4 raises an error" do
    omit_if_jruby('String#replace')
    assert_raise(ArgumentError){
      suppress_warning{
        proc do
          $SAFE = 4
          @string1.replace('world')
        end.call
      }
    }
  end
  
  test "attempting a replace a string in $SAFE mode 3 or less does not raise an error" do
    omit_if_jruby('String#replace')
    assert_nothing_raised{
      suppress_warning{
        proc do
          $SAFE = 3
          @string1.taint
          @string1.replace('test')
        end.call
      }
    }
  end

  test "replace accepts a single string argument only" do
    assert_raise(ArgumentError){ @string1.replace("x","y") }
    assert_raise(TypeError){ @string1.replace(1) }
  end

  test "replace raises an error on a frozen string" do
    assert_raise(RuntimeError){ @string1.freeze.replace('') }
  end

  def teardown
    @string1 = nil
    @string2 = nil
  end
end
