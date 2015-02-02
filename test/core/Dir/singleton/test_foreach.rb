######################################################################
# test_foreach.rb
#
# Test case for the Dir.foreach class method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Dir_Foreach_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  def setup
    if WINDOWS
      @entries = `dir /A /B`.split("\n").push('.', '..')
    else
      @entries = `ls -a1`.split("\n")
      @entries.push('.') unless @entries.include?('.')
      @entries.push('..') unless @entries.include?('..')
    end

    @pwd = Dir.pwd
    @enc = Encoding::UTF_16LE
  end

  test "foreach basic functionality" do
    assert_respond_to(Dir, :foreach)
    assert_nothing_raised{ Dir.foreach(@pwd){ } }
  end

  test "foreach yields the expected results" do
    entries = []
    assert_nothing_raised{ Dir.foreach(@pwd){ |e| entries.push(e) } }
    assert_equal(entries.sort, @entries.sort)
  end

  test "foreach returns an enumerator if no block is provided" do
    assert_kind_of(Enumerator, Dir.foreach)
    assert_kind_of(Enumerator, Dir.foreach(@pwd))
  end

  test "foreach accepts an optional encoding argument" do
    assert_nothing_raised{ Dir.foreach(@pwd, encoding: @enc) }
  end

  test "if an encoding is specified then the results are encoded" do
    enum = Dir.foreach(@pwd, encoding: @enc)
    enum.each{ |v| assert_true(v.encoding == @enc) }
  end

  test "foreach accepts a maximum of two arguments" do
    enum = Dir.foreach(@pwd, true, false, nil)
    assert_raises(ArgumentError){ enum.each{} }
  end

  test "foreach requires a string argument" do
    assert_raises(TypeError){ Dir.foreach(1){} }
    assert_raises(TypeError){ Dir.foreach([]){} }
  end

  def teardown
    @pwd     = nil
    @enc     = nil
    @entries = nil
  end
end
