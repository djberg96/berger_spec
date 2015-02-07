#########################################################################
# test_detect.rb
#
# Test suite for the Enumerable#detect instance method and the
# Enumerable#find alias.
#########################################################################
require 'test/helper'
require 'test-unit'

class MyEnumDetect
  include Enumerable

  attr_accessor :arg1, :arg2, :arg3

  def initialize(arg1=1, arg2=2, arg3=3)
    @arg1 = arg1
    @arg2 = arg2
    @arg3 = arg3
  end

  def each
    yield @arg1
    yield @arg2
    yield @arg3
  end

  def call
    "ifnone"
  end
end

class TC_Enumerable_Detect_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @enum   = MyEnumDetect.new(1, 2, 3)
    @lambda = lambda{ 'test' }
    @custom = MyEnumDetect.new
  end

  test "detect basic functionality" do
    assert_respond_to(@enum, :detect)
    assert_nothing_raised{ @enum.detect{} }
  end

  test "detect returns the expected results" do
    assert_equal(2, @enum.detect{ |e| e > 1 })
    assert_equal(nil, @enum.detect{ |e| e > 7 })
  end

  test "detect with a proc argument returns the expected results" do
    assert_equal(2, @enum.detect(@lambda){ |e| e > 1 })
    assert_equal('test', @enum.detect(@lambda){ |e| e > 7 })
  end

  test "detect accepts an argument that responds to the call method" do
    assert_nothing_raised{ @enum.detect(@custom){ |e| e > 1000 } }
    assert_equal("ifnone", @enum.detect(@custom){ |e| e > 1000 })
  end

  test "detect with true passed as a block argument returns the first element" do
    assert_equal(1, @enum.detect{ true })
  end

  test "detect with an empty block returns nil" do
    assert_nil(@enum.detect{})
  end

  test "find is an alias for detect" do
    msg = "=> Known issue in MRI"
    assert_respond_to(@enum, :find)
    assert_alias_method(@enum, :find, :detect)
  end

  test "detect without a block behaves as expected" do
    assert_kind_of(Enumerator, @enum.detect)
  end

  test "detect accepts only one argument" do
    assert_raise(ArgumentError){ @enum.detect(5, 7) }
  end

  test "the argument to detect must respond to call" do
    assert_raise(NoMethodError){ @enum.detect('test'){ |e| e > 7 } }
  end

  def teardown
    @enum   = nil
    @lambda = nil
  end
end
