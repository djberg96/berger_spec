########################################################################
# test_object_id.rb
#
# Test case for the Object#object_id instance method and the
# Object#__id__ alias.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_Object_ObjectId_InstanceMethod < Test::Unit::TestCase
  def setup
    @object = Object.new
  end

  test "object_id basic functionality" do
    assert_respond_to(@object, :object_id)
    assert_nothing_raised{ @object.object_id }
    assert_kind_of(Integer, @object.object_id)
  end

  test "id is an synonym for object_id" do
    assert_respond_to(@object, :__id__)
    assert_nothing_raised{ @object.__id__ }
    assert_kind_of(Integer, @object.__id__)
    assert_equal(@object.__id__, @object.object_id)
  end

  def teardown
    @object = nil
  end
end
