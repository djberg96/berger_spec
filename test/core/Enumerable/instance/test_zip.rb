###############################################################################
# test_zip.rb
#
# Test case for the Enumerable#zip instance method.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_Enumerable_Zip_InstanceMethod < Test::Unit::TestCase
  class AZip
    def to_ary
      ['x', 'y', 'z']
    end
  end

  def setup
    @arr_chr = ['a', 'b', 'c']
    @arr_int = [1, 2, 3]
    @arr_flt = [1.0, 2.5, 0.75]
    @arr_mix = ['a', 1, 2.5]
    @custom  = AZip.new
  end

  test "zip basic functionality" do
    assert_respond_to(@arr_chr, :zip)
    assert_nothing_raised{ @arr_chr.zip }
    assert_kind_of(Array, @arr_chr.zip)
  end

  test "zip with no arguments returns the expected result" do
    assert_equal([['a'], ['b'], ['c']], @arr_chr.zip)
    assert_equal([[1], [2], [3]], @arr_int.zip)
    assert_equal([[1.0], [2.5], [0.75]], @arr_flt.zip)
    assert_equal([['a'], [1], [2.5]], @arr_mix.zip)
  end

  test "zip with a single argument returns the expected result" do
    assert_equal([['a', 1], ['b', 2], ['c', 3]], @arr_chr.zip(@arr_int))
    assert_equal([[1, 1.0], [2, 2.5], [3, 0.75]], @arr_int.zip(@arr_flt))
    assert_equal([[1.0, 'a'], [2.5, 1], [0.75, 2.5]], @arr_flt.zip(@arr_mix))
    assert_equal([[1, 1], [2, 2], [3, 3]], @arr_int.zip(@arr_int))
  end

  test "zip with multiple arguments returns the expected result" do
    assert_equal(
      [['a', 1, 1.0], ['b', 2, 2.5], ['c', 3, 0.75]],
      @arr_chr.zip(@arr_int, @arr_flt)
    )

    assert_equal(
      [['a', 1, 1.0, 'a'], ['b', 2, 2.5, 1], ['c', 3, 0.75, 2.5]],
      @arr_chr.zip(@arr_int, @arr_flt, @arr_mix)
    )
  end

  test "zip with mismatched arguments returns the expected result" do
    assert_equal([[1, nil], [2, nil], [3, nil]], @arr_int.zip([]))
    assert_equal([[1, 'a'], [2, nil], [3, nil]], @arr_int.zip(['a']))
    assert_equal([[1, 'a'], [2, 'b'], [3, nil]], @arr_int.zip(['a','b']))
    assert_equal([[1, 'a'], [2, 'b'], [3, 'c']], @arr_int.zip(['a','b', 'c', 'd']))
  end

  test "zip accepts a block and returns expected result" do
    array = []
    assert_nothing_raised{ @arr_int.zip{ } }
    assert_nothing_raised{ @arr_int.zip(@arr_chr){ |e| array << e } }
    assert_equal([[1, 'a'], [2, 'b'], [3, 'c']], array)
  end

  test "zip honors custom to_ary method" do
    assert_nothing_raised{ @arr_int.zip(@custom) }
    assert_equal([[1,'x'], [2,'y'], [3,'z']], @arr_int.zip(@custom))
  end

  test "calling zip on empty array returns empty array" do
    assert_equal([], [].zip)
    assert_equal([], [].zip([]))
    assert_equal([], [].zip([1,2,3]))
  end

  test "calling zip with hash argument works as expected" do
    assert_equal([[1, [1, 2]], [2, [3, 4]], [3, nil]], @arr_int.zip({1=>2,3=>4}))
  end

  test "calling zip on array of nils with nil arguments works as expected" do
    assert_equal([[nil,nil],[nil,nil]], [nil,nil].zip([nil,nil]))
  end

  test "passing an invalid argument raises a TypeError" do
    assert_raise(TypeError){ @arr_int.zip(1) }
    assert_raise(TypeError){ @arr_int.zip(nil) }
  end

  def teardown
    @arr_chr = nil
    @arr_int = nil
    @arr_flt = nil
    @arr_mix = nil
    @custom  = nil
  end
end
