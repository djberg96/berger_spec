######################################################################
# test_english.rb
#
# Test case for the English library.
######################################################################
require 'test/unit'
require 'test/helper'
require 'English'

class TC_English_Stdlib < Test::Unit::TestCase
  include Test::Helper

  def setup
    suppress_warning do
      $\ = "\n"
      $; = "--"
      $, = "++"
    end
  end

  test "$ARGV maps to $*" do
    assert_not_nil($ARGV)
    assert_equal($*, $ARGV)
  end

  test "$CHILD_STATUS maps to $?" do
    omit_if_java("$CHILD_STATUS")
    Process.waitpid(fork{})
    assert_not_nil($CHILD_STATUS)
    assert_equal($?, $CHILD_STATUS)
  end

  test "$DEFAULT_INPUT maps to $<" do
    assert_not_nil($DEFAULT_INPUT)
    assert_equal($<, $DEFAULT_INPUT)
  end

  test "$DEFAULT_OUTPUT maps to $>" do
    assert_not_nil($DEFAULT_OUTPUT)
    assert_equal($>, $DEFAULT_OUTPUT)
  end

  test "$ERROR_INFO maps to $!" do
    begin
      raise "error_info"
    rescue
      assert_not_nil($ERROR_INFO)
      assert_equal($!, $ERROR_INFO)
    end
  end

  test "$ERROR_POSITION maps to $@" do
    begin
      raise "error_position"
    rescue
      assert_not_nil($ERROR_POSITION)
      assert_equal($@, $ERROR_POSITION)
    end
  end

  test "$FS and $FIELD_SEPARATOR maps to $;" do
    assert_not_nil($FS)
    assert_not_nil($FIELD_SEPARATOR)
    assert_equal($;, $FIELD_SEPARATOR)
  end

  test "$OFS and $OUTPUT_FIELD_SEPARATOR maps to $," do
    assert_not_nil($OFS)
    assert_not_nil($OUTPUT_FIELD_SEPARATOR)
    assert_equal($,, $OUTPUT_FIELD_SEPARATOR)
  end

  test "$NR and $INPUT_LINE_NUMBER maps to $." do
    assert_not_nil($NR)
    assert_not_nil($INPUT_LINE_NUMBER)
    assert_equal($., $INPUT_LINE_NUMBER)
  end

  test "$RS and $INPUT_RECORD_SEPARATOR maps to $/" do
    assert_not_nil($RS)
    assert_not_nil($INPUT_RECORD_SEPARATOR)
    assert_equal($/, $INPUT_RECORD_SEPARATOR)
  end

  test "$ORS and $OUTPUT_RECORD_SEPARATOR maps to $\\" do
    assert_not_nil($ORS)
    assert_not_nil($OUTPUT_RECORD_SEPARATOR)
    assert_equal($\, $INPUT_RECORD_SEPARATOR)
  end

  test "$LAST_MATCH_INFO maps to $~" do
    "foo" =~ /foo/
    assert_not_nil($LAST_MATCH_INFO)
    assert_equal($~, $LAST_MATCH_INFO)
  end

  test "$LAST_PAREN_MATCH maps to $+" do
    "foo" =~ /(.*)/
    assert_not_nil($LAST_PAREN_MATCH)
    assert_equal($+, $LAST_PAREN_MATCH)
  end

  # TODO: improve this
  #def test_english_last_read_line
  #  if $_
  #    assert_not_nil($LAST_READ_LINE)
  #    assert_equal($_, $LAST_READ_LINE)
  #  end
  #end

  test '$LOADED_FEATURES maps to $"' do
    assert_not_nil($LOADED_FEATURES)
    assert_equal($", $LOADED_FEATURES)
  end

  test "$MATCH maps to $&" do
    "foo" =~ /foo/
    assert_not_nil($MATCH)
    assert_equal($&, $MATCH)
  end

  test "$PID and $PROCESS_ID maps to $$" do
    assert_not_nil($PID)
    assert_not_nil($PROCESS_ID)
    assert_equal($$, $PID)
  end

  test "$POSTMATCH maps to $'" do
    "foo" =~ /foo/i
    assert_not_nil($POSTMATCH)
    assert_equal($', $POSTMATCH)
  end

  test "$PREMATCH maps to $`" do
    "foo" =~ /foo/i
    assert_not_nil($PREMATCH)
    assert_equal($`, $PREMATCH)
  end

  test "$PROGRAM_NAME maps to $0" do
    assert_not_nil($PROGRAM_NAME)
    assert_equal($0, $PROGRAM_NAME)
  end

  def teardown
    $\ = nil
    $; = nil
    $, = nil
  end
end
