########################################################################
# test_comparable.rb
#
# These tests validate the various Comparable mixin methods for the
# Time class.
########################################################################
require 'test/helper'
require 'test/unit'

class TC_Time_Comparable_InstanceMethods < Test::Unit::TestCase
  include Test::Helper

  def setup
    @now    = Time.now
    @future = @now + 86400
    @past   = @now - 86400
  end

  test "between? returns expected results" do
    assert_boolean(@now.between?(@past, @future))
    assert_true(@now.between?(@past, @future))
    assert_false(@now.between?(@future, @past))
    assert_true(@now.between?(@now, @now))
    assert_true(@now.between?(@now, @future))
    assert_false(@now.between?(@now, @past))
  end

  test "between? raises an error if arguments are invalid" do
    assert_raise(ArgumentError){ @now.between?(0, @future) }
    assert_raise(ArgumentError){ @now.between?(@now, nil) }
  end

  test "between? requires two arguments" do
    assert_raise(ArgumentError){ @now.between?(@now) }
    assert_raise(ArgumentError){ @now.between?(@now, @now, @now) }
  end

  test "> returns expected results" do
    assert_boolean(@now > @future)
    assert_false(@now > @now)
    assert_false(@now > @future)
    assert_true(@future > @now)
  end

  test "> raises an error if arguments are invalid" do
    assert_raise(ArgumentError){ @now > 1000 }
    assert_raise(ArgumentError){ @now > true }
  end

  test "> requires one argument only" do
    assert_raise(ArgumentError){ @now.send(:>, @future, 1) }
  end

  test ">= returns expected results" do
    assert_boolean(@now >= @future)
    assert_true(@now >= @now)
    assert_false(@now >= @future)
    assert_true(@future >= @now)
  end

  test ">= raises an error if arguments are invalid" do
    assert_raise(ArgumentError){ @now >= 1000 }
    assert_raise(ArgumentError){ @now >= true }
  end

  test ">= requires one argument only" do
    assert_raise(ArgumentError){ @now.send(:>=, @future, 1) }
  end

  test "== returns expected results" do
    assert_boolean(@now == @future)
    assert_true(@now == @now)
    assert_false(@now == @future)
    assert_false(@future == @now)
  end

  test "== returns boolean for seemingly illegal equality checks" do
    assert_false(@now == 1000) 
    assert_false(@now == true)
  end

  test "== requires one argument only" do
    assert_raise(ArgumentError){ @now.send(:==, @future, 1) }
  end

  test "<= returns expected results" do
    assert_boolean(@now <= @future)
    assert_true(@now <= @now)
    assert_true(@now <= @future)
    assert_false(@future <= @now)
  end

  test "<= raises an error if arguments are invalid" do
    assert_raise(ArgumentError){ @now <= 1000 }
    assert_raise(ArgumentError){ @now <= true }
  end

  test "<= requires one argument only" do
    assert_raise(ArgumentError){ @now.send(:<=, @future, 1) }
  end

  test "< returns expected results" do
    assert_boolean(@now < @future)
    assert_true(@now < @future)
    assert_false(@future < @now)
  end

  test "< raises an error if arguments are invalid" do
    assert_raise(ArgumentError){ @now < 1000 }
    assert_raise(ArgumentError){ @now < true }
  end

  test "< requires one argument only" do
    assert_raise(ArgumentError){ @now.send(:<, @future, 1) }
  end

  def teardown
    @now    = nil
    @future = nil
    @past   = nil
  end
end
