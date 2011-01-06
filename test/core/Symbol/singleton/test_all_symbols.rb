###############################################################################
# test_all_symbols.rb
#
# Test case for the Symbol.all_symbols singleton method.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_Symbol_AllSymbols_SingletonMethod < Test::Unit::TestCase
  test "all_symbols basic functionality" do
    assert_respond_to(Symbol, :all_symbols)
    assert_nothing_raised{ Symbol.all_symbols }
    assert_kind_of(Array, Symbol.all_symbols)
  end

  test "all elements of the array returned by all_symbols are symbols" do
    assert_true(Symbol.all_symbols.all?{ |s| s.is_a?(Symbol) })
  end

  test "all_symbols returns the expected number of symbols" do
    assert_true(Symbol.all_symbols.size >= 100)
  end

  # We can't pass a literal symbol here or it will be evaluated first
  test "all_symbols reports newly defined symbols" do
    assert_false(Symbol.all_symbols.include?(":abcxyz".to_sym))
    eval ":asdfasdf"
    assert_true(Symbol.all_symbols.include?(":abcxyz".to_sym))
  end

  test "all_symbols does not accept any arguments" do
    assert_raise(ArgumentError){ Symbol.all_symbols(true) }
  end

  test "all_symbols does not accept assignment" do
    assert_raise(NoMethodError){ Symbol.all_symbols = [:foo, :bar] }
  end
end
