######################################################################
# test_each.rb
#
# Test case for the Dir#each instance method.
######################################################################
require "test/helper"
require "test/unit"

class TC_Dir_Each_InstanceMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    @pwd = pwd_n
    @dir = Dir.new(@pwd)
    if WINDOWS
      @entries = `dir /A /B`.split("\n").push('.', '..')
    else
      @entries = `ls -a1`.split("\n")
      @entries.push('.') unless @entries.include?('.')
      @entries.push('..') unless @entries.include?('..')
    end
  end

  test "each basic functionality" do
    assert_respond_to(@dir, :each)
    assert_nothing_raised{ @dir.each{} }
  end

  test "each returns the expected results" do
    array = []
    assert_nothing_raised{ @dir.each{ |dir| array.push(dir) }}
    assert_kind_of(String, array.first)
    assert_kind_of(String, array.last)
    assert_equal(@entries.sort, array.sort)
  end

  test "each does not take any arguments" do
    assert_raises(ArgumentError){ @dir.each(1){} }
  end

  test "each returns an enumerator if no block is given" do
    assert_kind_of(Enumerable::Enumerator, @dir.each)
  end

  def teardown
    @dir     = nil
    @pwd     = nil
    @entries = nil
  end
end
