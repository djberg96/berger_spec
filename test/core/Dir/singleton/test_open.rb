######################################################################
# test_open.rb
#
# Test case for the Dir.open class method.
######################################################################
require 'test/helper'
require 'test/unit'

class TC_Dir_Open_SingletonMethod < Test::Unit::TestCase
  def setup
    @dir = 'test'
    @pwd = Dir.pwd
    @handle = nil
  end

  test "open method basic functionality" do
    assert_respond_to(Dir, :open)
  end

  test "open method accepts a block" do
    assert_nothing_raised{ Dir.open(@pwd){} }
  end

  test "open returns nil if a block is provided" do
    assert_nil(Dir.open(@pwd){})
  end

  test "open yields a Dir object if a block is provided" do
    Dir.open(@pwd){ |dir| assert_kind_of(Dir, dir) }
  end

  test "open returns a Dir object if no block is provided" do
    assert_nothing_raised{ @handle = Dir.open(@pwd) }
    assert_kind_of(Dir, @handle)
  end

  test "open requires a string argument" do
    assert_raises(TypeError){ Dir.open(1) }
    assert_raises(TypeError){ Dir.open([]) }
  end

  test "open requires one argument only" do
    assert_raises(ArgumentError){ Dir.open }
    assert_raises(ArgumentError){ Dir.open(@pwd, @pwd) }
  end

  def teardown
    @handle.close if @handle

    @dir = nil
    @pwd = nil
  end
end
