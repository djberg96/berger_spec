######################################################################
# test_intern.rb
#
# Test case for the String#intern instance method and its aliases.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_String_Intern_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @string = '<html><b>Hello</b></html>'
  end

  def test_intern_basic
    assert_respond_to(@string, :intern)
    assert_nothing_raised{ @string.intern }
    assert_kind_of(Symbol, @string.intern)
  end

  def test_intern
    assert_equal(@string, @string.intern.to_s)
    assert_equal(:foo, "foo".intern)
    assert_equal(:Foo, "Foo".intern)
    assert_equal(:'cat and dog', "cat and dog".intern)
  end

  def test_to_sym_alias
    assert_equal(@string, @string.to_sym.to_s)
    assert_equal(:foo, "foo".to_sym)
    assert_equal(:Foo, "Foo".to_sym)
    assert_equal(:'cat and dog', "cat and dog".to_sym)
  end

  def test_intern_edge_cases
    assert_nothing_raised{ ' '.intern }
    assert_nothing_raised{ '0'.intern }
    assert_nothing_raised{ 'nil'.intern }
    assert_nothing_raised{ 'true'.intern }
    assert_nothing_raised{ 'false'.intern }
  end

  def teardown
    @string = nil
  end
end
