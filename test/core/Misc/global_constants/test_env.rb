###############################################################################
# test_env.rb
#
# Test case for the special ENV global constant. It walks and talks like a
# Hash, but it's not actually a hash.
#
# Note that, if it were up to me, it *would* be an instance of Hash. IMHO
# that portion of hash.c could use some serious refactoring. I don't test
# every single ENV method here because, in practice, programmers use a very
# limited subset of the available methods. Mostly, it's just ENV#[] and
# ENV#[]=.
###############################################################################
require 'test/helper'
require 'test/unit'

class TC_Env_Global_Constant < Test::Unit::TestCase
  include Test::Helper

  def setup
    @cmd = WINDOWS ? 'set' : 'env'
    @env = {}
    `#{@cmd}`.split("\n").each{ |str|
      str =~ /(.*?)\=(.*)/
      @env[$1] = $2.to_s
    }
  end

  test "ENV constant exists" do
    assert_not_nil(ENV)
  end

  # These could fail if you've messed with your shell environment
  test "ENV keys should match shell environment" do
    assert_equal(@env.keys.sort, ENV.keys.sort)
  end

  test "ENV values should match shell environment" do
    assert_equal(@env.values.sort, ENV.values.sort, @env.values.sort - ENV.values.sort)
  end

  # Because ENV is not technically a hash, we validate all of the custom methods here.
  test "basic check for various ENV methods" do
    assert_respond_to(ENV, :[])
    assert_respond_to(ENV, :[]=)
    assert_respond_to(ENV, :clear)
    assert_respond_to(ENV, :delete)
    assert_respond_to(ENV, :delete_if)
    assert_respond_to(ENV, :each)
    assert_respond_to(ENV, :each_pair)
    assert_respond_to(ENV, :each_key)
    assert_respond_to(ENV, :each_value)
    assert_respond_to(ENV, :empty?)
    assert_respond_to(ENV, :fetch)
    assert_respond_to(ENV, :has_key?)
    assert_respond_to(ENV, :has_value?)
    assert_respond_to(ENV, :inspect)
    assert_respond_to(ENV, :invert)
    assert_respond_to(ENV, :length)
    assert_respond_to(ENV, :include?)
    assert_respond_to(ENV, :key?)
    assert_respond_to(ENV, :keys)
    assert_respond_to(ENV, :rehash)
    assert_respond_to(ENV, :reject)
    assert_respond_to(ENV, :reject!)
    assert_respond_to(ENV, :replace)
    assert_respond_to(ENV, :select)
    assert_respond_to(ENV, :shift)
    assert_respond_to(ENV, :size)
    assert_respond_to(ENV, :store)
    assert_respond_to(ENV, :to_a)
    assert_respond_to(ENV, :to_hash)
    assert_respond_to(ENV, :to_s)
    assert_respond_to(ENV, :update)
    assert_respond_to(ENV, :value?)
    assert_respond_to(ENV, :values)
    assert_respond_to(ENV, :values_at)
  end

  def teardown
    @env = nil
    @cmd = nil
  end
end
