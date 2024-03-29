###############################################################################
# test_copies.rb
#
# Test case for the String#* instance method.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_String_Copies_InstanceMethod < Test::Unit::TestCase
   class MyString < String; end

   def setup
      @string = 'ho! '
   end

   def test_copies_basic
      assert_respond_to(@string, :*)
      assert_nothing_raised{ @string * 3 }
      assert_kind_of(String, @string * 3)
   end

   def test_copies
      assert_equal('ho! ho! ho! ', @string * 3)
      assert_equal('111', '1' * 3)
      assert_equal('ho! ', @string * 1)
   end

   def test_copies_edge_cases
      assert_equal('', @string * 0)
      assert_equal('***', '*' * 3)
      assert_equal('nilnilnil', 'nil' * 3)
      assert_equal('', '' * 1000)
   end

   # JRUBY-1752
   #
   # Apparently this changed at some point
   def test_copies_returns_basic_string_class
      assert_nothing_raised{ @string = MyString.new('hello') }
      assert_kind_of(String, @string * 3)
   end

   def test_copies_expected_errors
      assert_raise(ArgumentError){ @string * -1 }
      assert_raise(TypeError){ @string * 'test' }
      assert_raise(ArgumentError){ @string.send(:*, 1, 2) }
   end

   def teardown
      @string = nil
   end
end
