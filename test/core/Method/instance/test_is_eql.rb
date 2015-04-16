########################################################################
# test_is_eql.rb
#
# Test case for the Method#.eql?( instance method.
########################################################################
require 'test/helper'
require 'test/unit'

class MethodEql
  def foo; end
  def bar; some_method; end  # Synonym, but not true alias
  alias baz foo
end

class TC_Method_IsEql_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @meth  = MethodEquality.instance_method(:foo)
    @syn   = MethodEquality.instance_method(:bar)
    @alias = MethodEquality.instance_method(:baz)
  end

  test "eql? basic functionality" do
    assert_respond_to(@meth, :eql?)
    assert_nothing_raised{ @meth.eql?(@syn) }
    assert_boolean(@meth.eql?( @alias))
  end

  test "eql? returns true for itself" do
    assert_true(@meth.eql?(@meth))
    assert_true(@syn.eql?(@syn))
    assert_true(@alias.eql?(@alias))
  end

  test "eql? returns false for synonyms" do
    assert_equal(false, @meth.eql?(@syn))
  end

  test "eql? returns true for an alias" do
    assert_true(@meth.eql?(@alias))
  end

  test "eql? returns false for a non-method object" do
    assert_false(@meth.eql?('foo'))
    assert_false(@meth.eql?('foo'.to_sym))
  end

  test "eql? method takes one argument" do
    assert_raise(ArgumentError){ @meth.eql? }
    assert_raise(ArgumentError){ @meth.eql?(@meth, @syn) }
  end

  def teardown
    @meth  = nil
    @syn   = nil
    @alias = nil
  end
end
