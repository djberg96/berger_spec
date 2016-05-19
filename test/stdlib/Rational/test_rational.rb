######################################################################
# test_rational.rb
#
# Test case for the Rational class (and method).
######################################################################
require "rational"
require "test/unit"

class TC_Rational_Stdlib < Test::Unit::TestCase
  def setup
    @rat1 = Rational(3,4)      # Basic
    @rat2 = Rational(1,1)      # One
    @rat3 = Rational(2,3)      # Infinite division
    @rat4 = Rational(0,3)      # Zero numerator
    @rat5 = Rational(9)        # Default denominator
    @rat6 = Rational(3,-4)     # Negative denominator
    @rat7 = Rational(-3,-4)    # Both negative
    @rat8 = Rational(-3,4)     # Negative numerator
    @rat9 = Rational(0,-3)     # Zero numerator, negative denominator
  end

  test "abs basic functionality" do
    assert_respond_to(@rat6, :abs)
  end

  test "multiplication basic functionality" do
    assert_respond_to(@rat1, :*)
    assert_nothing_raised{ @rat1 * @rat2 }
    assert_nothing_raised{ @rat1 * @rat4 }
    assert_nothing_raised{ @rat1 * @rat7 }
  end

  test "multiplication with another rational returns the expected value" do
    assert_equal(Rational(1,2), @rat1 * @rat3)
    assert_equal(Rational(9,16), @rat1 * @rat7)
  end

  test "multiplication with an integer returns the expected value" do
    assert_equal(Rational(3,4), @rat1 * 1)
    assert_equal(Rational(9,4), @rat1 * 3)
    assert_equal(Rational(3,1), @rat1 * 4)
    assert_equal(0.375, @rat1 * 0.5)
  end

  test "divmod basic functionality" do
    assert_respond_to(@rat1, :divmod)
    assert_nothing_raised{ @rat1.divmod(@rat2) }
  end

  test "divmod returns the expected value" do
    assert_equal([0, Rational(3,4)], @rat1.divmod(@rat2))
    assert_equal([1, Rational(1,12)], @rat1.divmod(@rat3))
    assert_equal([1, Rational(0,1)], @rat1.divmod(@rat7))    # ??
  end

  test "custom to_s implementation" do
    assert_respond_to(@rat1, :to_s)
    assert_nothing_raised{ @rat1.to_s }
    assert_kind_of(String, @rat1.to_s)
    assert_equal("3/4", @rat1.to_s)
    assert_equal("3/4", @rat7.to_s)
  end

  # I don't entirely understand what Rational#coerce is supposed to do
  # or if it's even supposed to be public.
  test "coerce basic functionality" do
    assert_respond_to(@rat1, :coerce)
    assert_nothing_raised{ @rat1.coerce(9) }
    assert_nothing_raised{ @rat1.coerce(0.5) }
    #assert_equal(Rational(9,1), @rat1.coerce(9))
  end

  test "a rational cannot be coerced into an invalid type" do
    assert_raises(TypeError){ Rational(3,4).coerce("foo") }
  end

  test "modulo basic functionality" do
    assert_respond_to(@rat1, :%)
    assert_nothing_raised{ @rat1 % @rat2 }
  end

  test "modulo with a rational returns the expected value" do
    assert_equal(Rational(3,4), @rat1 % @rat2)
    assert_equal(Rational(1,12), @rat1 % @rat3)
    assert_equal(Rational(0,1), @rat1 % @rat7)
  end

  test "modulo with an integer returns the expected value" do
    assert_equal(Rational(3,4), @rat1 % 2)
    assert_equal(Rational(-1,4), @rat1 % -1)
    assert_equal(0.25, @rat1 % 0.5)
  end

  test "division basic functionality" do
    assert_respond_to(@rat1, :/)
    assert_nothing_raised{ @rat1 / @rat2 }
  end

  test "division with a rational returns the expected value" do
    assert_equal(Rational(3,4), @rat1 / @rat2)
    assert_equal(Rational(3,2), @rat1 / Rational(1,2))
  end

  test "division with an integer returns the expected value" do
    assert_equal(Rational(3,8), @rat1 / 2)
    assert_equal(0.375, @rat1 / 2.0)
  end

  test "custom hash implementation" do
    assert_respond_to(@rat1, :hash)
    assert_nothing_raised{ @rat1.hash }
    assert_nothing_raised{ @rat4.hash }
    assert_kind_of(Fixnum, @rat1.hash)
  end

  test "equality operator basic functionality" do
    assert_respond_to(@rat1, :==)
  end

  test "equality operator returns the expected value" do
    assert_true(@rat1 == @rat1)
    assert_true(@rat1 == Rational(9,12))
    assert_true(@rat4 == @rat9)
    assert_true(@rat6 == @rat8)
    assert_true(@rat1 == 0.75)
    assert_true(@rat6 == @rat8)
    assert_false(@rat1 == @rat2)
  end

  test "addition operator basic functionality" do
    assert_respond_to(@rat1, :+)
    assert_nothing_raised{ @rat1 + @rat2 }
    assert_nothing_raised{ @rat1 + @rat4 }
  end

  test "addition operator returns the expected value" do
    assert_equal(Rational(17, 12), @rat1 + @rat3)
    assert_equal(Rational(3,4), @rat1 + @rat4)
    assert_equal(Rational(3,2), @rat1 + @rat7)
    assert_equal(Rational(0,1), @rat1 + @rat8)
  end

  test "the Rational() singleton method basic functionality" do
    assert_kind_of(Rational, @rat1)
    assert_nothing_raised{ Rational(0,1) }
    assert_nothing_raised{ Rational(Rational(1,2), 1) }
  end

  test "numerator basic functionality" do
    assert_respond_to(@rat1, :numerator)
  end

  test "numerator returns expected value" do
    assert_equal(3, @rat1.numerator)
    assert_equal(0, @rat4.numerator)
    assert_equal(9, @rat5.numerator)
    assert_equal(-3, @rat6.numerator)
    assert_equal(3, @rat7.numerator)
    assert_equal(-3, @rat8.numerator)
    assert_equal(0, @rat9.numerator)
  end

  test "denominator basic functionality" do
    assert_respond_to(@rat1, :denominator)
  end

  test "denominator returns expected value" do
    assert_equal(4, @rat1.denominator)
    assert_equal(1, @rat4.denominator) # Reduced
    assert_equal(1, @rat5.denominator)
    assert_equal(4, @rat6.denominator)
    assert_equal(4, @rat7.denominator)
    assert_equal(4, @rat8.denominator)
    assert_equal(1, @rat9.denominator) # Reduced
  end

  test "custom to_f method basic functionality" do
    assert_respond_to(@rat1, :to_f)
  end

  test "custom to_f returns expected value" do
    assert_equal(0.75, @rat1.to_f)
    assert_equal(1.0, @rat2.to_f)
    assert_equal(0.0, @rat4.to_f)
    assert_equal(-0.75, @rat6.to_f)
    assert_equal(0.75, @rat7.to_f)
    assert_equal(-0.75, @rat8.to_f)
    assert_equal(0.0, @rat9.to_f)
  end

  test "custom to_i method basic functionality" do
    assert_respond_to(@rat2, :to_i)
  end

  test "custom to_i returns expected value" do
    assert_equal(0, @rat1.to_i)
    assert_equal(1, @rat2.to_i)
    assert_equal(0, @rat4.to_i)
    assert_equal(9, @rat5.to_i)
    assert_equal(0, @rat6.to_i)
    assert_equal(0, @rat7.to_i)
    assert_equal(0, @rat8.to_i)
    assert_equal(0, @rat9.to_i)
  end

  test "exponentiation basic functionality" do
    assert_respond_to(@rat1, :**)
  end

  # TODO: Add some expected value tests

  test "subtraction basic functionality" do
      assert_respond_to(@rat1, :-)
      assert_nothing_raised{ @rat1 - @rat2 }
      assert_nothing_raised{ @rat1 - @rat4 }
  end

  test "substraction returns expected value" do
    assert_equal(Rational(1, 12), @rat1 - @rat3)
    assert_equal(Rational(3,4), @rat1 - @rat4)
  end

  test "spaceship operator basic functionality" do
    assert_respond_to(@rat1, :<=>)
    assert_nothing_raised{ @rat1 <=> @rat2 }
    assert_nothing_raised{ @rat1 <=> @rat4 }
  end

  test "spaceship operator returns expected value" do
    assert_equal(-1, @rat1 <=> @rat2)
    assert_equal(1, @rat1 <=> @rat3)
    assert_equal(0, @rat1 <=> Rational(3,4))
  end

  test "custom inspect method" do
    assert_respond_to(@rat1, :inspect)
    assert_equal("(3/4)", @rat1.inspect)
    assert_equal("(0/1)", @rat4.inspect) # Reduced
    assert_equal("(9/1)", @rat5.inspect)
  end

  test "traditional constructor does not exist" do
    assert_raises(NoMethodError){ Rational.new(3,4) }
  end

  test "constructor requires two arguments only" do
    assert_raises(ArgumentError){ Rational() }
    assert_raises(ArgumentError){ Rational(1,2,3) }
  end

  test "constructor can accept another rational in its constructor" do
    assert_nothing_raised{ Rational(1, Rational(2,3)) }
  end

  test "a zero denominator raises an error" do
    assert_raises(ZeroDivisionError){ Rational(0,0) }
    assert_raises(ZeroDivisionError){ Rational(1,0) }
    assert_raises(ZeroDivisionError){ Rational(0,3) / Rational(0,8) }
    assert_raises(ZeroDivisionError){ Rational(3,4) % Rational(0,3) }
    assert_raises(ZeroDivisionError){ Rational(3,4).divmod Rational(0,3) } 
  end

  test "an invalid argument raises an error" do
    assert_raises(ArgumentError){ Rational("bogus", 1) }
    assert_raises(TypeError){ Rational(nil) }
    assert_raises(TypeError){ Rational(true) }
    assert_raises(TypeError){ Rational(false) }
  end

  def teardown
    @rat1 = nil
    @rat2 = nil
    @rat3 = nil
    @rat4 = nil
    @rat5 = nil
    @rat6 = nil
    @rat7 = nil
    @rat8 = nil
    @rat9 = nil
  end
end
