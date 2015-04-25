########################################################################
# test_class_variables.rb
#
# Test case for the Module#class_variables instance method.
########################################################################
require 'test/helper'
require 'test/unit'

module CV_Mod_A
  @@var1 = 1
end

class CV_Class_A
  include CV_Mod_A
  @@var2 = 2
end

# Overwrite the class variable
class CV_Class_B
  include CV_Mod_A
  @@var1 = 2
end

# Remove the class variable
class CV_Class_C
  @@var3 = 3
  @@var4 = 4
  remove_class_variable(:@@var3)
end

class TC_Module_ClassVariables_InstanceMethod < Test::Unit::TestCase
  def setup
    @obj_c = CV_Class_C.new
  end

  test "class_variables basic functionality" do
    assert_respond_to(CV_Mod_A, :class_variables)
    assert_nothing_raised{ CV_Mod_A.class_variables }
    assert_kind_of(Array, CV_Mod_A.class_variables)
  end

  test "class_variables returns expected result" do
    assert_equal([:@@var1], CV_Mod_A.class_variables)
    assert_equal([:@@var2, :@@var1], CV_Class_A.class_variables)
    assert_equal([:@@var1], CV_Class_B.class_variables)
  end

  # See CV_Class_C above
  test "class_varaibles returns expected result after explicit removal" do
    assert_equal([:@@var4], CV_Class_C.class_variables)
  end

  test "class_variables returns expected result if inherit argument is false" do
    assert_equal([:@@var2, :@@var1], CV_Class_A.class_variables(true))
    assert_equal([:@@var2], CV_Class_A.class_variables(false))
  end

  test "class_variables accepts a maximum of one argument" do
    assert_raise(ArgumentError){ CV_Class_A.class_variables(true, false) }
  end

  def teardown
    @obj_c = nil
  end
end
