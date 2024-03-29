########################################################################
# test_glob.rb
#
# Test case for the Dir.glob class method.
########################################################################
require 'test/helper'
require 'test/unit'
require 'fileutils'

class TC_Dir_Glob_SingletonMethod < Test::Unit::TestCase
  include Test::Helper

  # Helper method to get just the basename of the filename. Results
  # are also sorted, since ordering is not guaranteed.
  #
  def base(files)
    files.map{ |f| File.basename(f) }.sort
  end

  def setup
    @foo_files = %w[a.c a.cpp b.c b.h g.rb d]
    @bar_files = %w[a.c a2.cpp a3.h a4.rb]
    @dot_files = %w[.a.p .abc .p a a.p]

    FileUtils.mkdir_p('foo/bar/baz')
    FileUtils.mkdir_p('dot')

    Dir.chdir('foo'){ @foo_files.each{ |f| FileUtils.touch(f) } }
    Dir.chdir('foo/bar'){ @bar_files.each{ |f| FileUtils.touch(f) } }
    Dir.chdir('dot'){ @dot_files.each{ |f| FileUtils.touch(f) } }

    # Windows does not allow these characters in file names
    unless WINDOWS
      @baz_files = %w/a* a? a** a^/
      Dir.chdir('foo/bar/baz'){ @baz_files.each{ |f| FileUtils.touch(f) } }
    end
  end

  test "globe basic functionality" do
    assert_respond_to(Dir, :glob)
    assert_nothing_raised{ Dir.glob("*") }
  end

  test "glob with dotmatch" do
    assert_equal(
      %w[. .. .a.p .abc .p a a.p],
      base(Dir.glob('dot/*', File::FNM_DOTMATCH))
    )

    assert_equal(
      %w[.a.p .p a.p],
      base(Dir.glob('dot/*p', File::FNM_DOTMATCH))
    )
  end

  test "glob with casefold" do
    assert_equal(%w[a.c a.cpp], base(Dir.glob('foo/A*', File::FNM_CASEFOLD)))
    assert_equal(%w[a.c a.cpp], base(Dir.glob('foo/a*', File::FNM_CASEFOLD)))
    assert_equal(%w[a a.p], base(Dir.glob('dot/A*', File::FNM_CASEFOLD)))
    assert_equal([], base(Dir.glob('dot/P*', File::FNM_CASEFOLD)))
  end

  test "glob with escape characters" do
    omit_if(WINDOWS, "glob with escape skipped on this platform")
    assert_equal(%w[a*], base(Dir.glob('foo/bar/baz/a\*')))
    assert_equal(%w[a**], base(Dir.glob('foo/bar/baz/a\*\*')))
    assert_equal(%w[a* a**], base(Dir.glob('foo/bar/baz/a\**')))
    assert_equal(%w[a?], base(Dir.glob('foo/bar/baz/a\?')))
    assert_equal(%w[a^], base(Dir.glob('foo/bar/baz/a\^')))
    assert_equal(%w[a^], base(Dir.glob('foo/bar/baz/a[\^]')))
  end

  test "glob with basic pattern" do
    assert_equal(%w[a.c a.cpp b.c b.h bar d g.rb], base(Dir.glob('foo/{*}')))
    assert_equal(%w[g.rb], base(Dir.glob('foo/{*.rb}')))
    assert_equal(%w[a.cpp g.rb], base(Dir.glob('foo/*.{rb,cpp}')))
    assert_equal(%w[a.cpp g.rb], base(Dir.glob('foo/*.{rb,cp}*')))
    assert_equal([], base(Dir.glob('foo/*.{}')))
  end

  test "glob with character list" do
    assert_equal(%w[d], base(Dir.glob('foo/[a-d]')))
    assert_equal(%w[a.c a.cpp], base(Dir.glob('foo/[a]*')))
    assert_equal(%w[a.c a.cpp b.c b.h bar d], base(Dir.glob('foo/[a-d]*')))
    assert_equal(%w[d g.rb], base(Dir.glob('foo/[^a-b]*')))

    if File.identical?(Dir.home, Dir.home.swapcase)
      assert_equal(%w[a.c a.cpp b.c b.h bar d g.rb], base(Dir.glob('foo/[A-Z]*')))
    else
      assert_equal([], base(Dir.glob('foo/[A-Z]*')))
    end
  end

  test "glob char list edge cases" do
    assert_equal([], Dir.glob('foo/[]'))
    assert_equal(['d'], base(Dir.glob('foo/[^]')))
  end

  test "glob with single character match" do
    assert_equal(%w[a.c], base(Dir.glob('foo/a.?')))
    assert_equal(%w[a.cpp], base(Dir.glob('foo/a.c?p')))
    assert_equal(%w[a.c b.c b.h bar], base(Dir.glob('foo/???')))
    assert_equal(%w[a.c b.c b.h], base(Dir.glob('foo/?.?')))
  end

  test "glob accepts metacharacters properly" do
    assert_nothing_raised{ Dir.glob("**") }
    assert_nothing_raised{ Dir.glob("foo.*") }
    assert_nothing_raised{ Dir.glob("foo.?") }
    assert_nothing_raised{ Dir.glob("*.[^r]*") }
    assert_nothing_raised{ Dir.glob("*.[a-z][a-z]") }
    assert_nothing_raised{ Dir.glob("*.{rb,h}") }
    assert_nothing_raised{ Dir.glob("*.\t") }
  end

  test "glob with star works as expected" do
    assert_equal(%w[a.c a.cpp b.c b.h bar d g.rb], base(Dir.glob('foo/*')))
    assert_equal(%w[a.c a.cpp b.c b.h bar d g.rb], base(Dir.glob('foo/****')))
    assert_equal(%w[a.c b.c], base(Dir.glob('foo/*.c')))
    assert_equal(%w[a.c a.cpp], base(Dir.glob('foo/a*')))
    assert_equal(%w[a.c a.cpp], base(Dir.glob('foo/a*c*')))
    assert_equal(%w[a.cpp], base(Dir.glob('foo/a*p*')))
    assert_equal(%w[a a.p], base(Dir.glob('dot/*')))
    assert_equal([], Dir.glob('x*'))
  end

  test "glob with double star works as expected" do
    assert_equal(%w[a.c a.cpp b.c b.h bar d g.rb], base(Dir.glob('foo/**')))
    assert_equal(%w[a.c a.c b.c], base(Dir.glob('**/*.c')))
    assert_equal(%w[a.c a.c b.c], base(Dir.glob('foo/**/*.c')))

    if WINDOWS
      assert_equal(
        %w[a.c a.c a.cpp a2.cpp a3.h a4.rb],
        base(Dir.glob('foo/**/a*'))
      )
    else
      assert_equal(
        %w[a* a** a.c a.c a.cpp a2.cpp a3.h a4.rb a? a^],
        base(Dir.glob('foo/**/a*'))
      )
    end

    assert_equal([], Dir.glob('**/x*'))
  end

  test "glob accepts flags properly" do
    assert_nothing_raised{ Dir.glob("*", File::FNM_DOTMATCH) }
    assert_nothing_raised{ Dir.glob("*", File::FNM_NOESCAPE) }
    assert_nothing_raised{ Dir.glob("*", File::FNM_PATHNAME) }
    assert_nothing_raised{ Dir.glob("*", File::FNM_CASEFOLD) }
  end

  test "the second argument to glob must be an integer" do
    assert_raises(TypeError){ Dir.glob("*", "*") }
    assert_raises(TypeError){ Dir.glob("*", []) }
  end

  def teardown
    @foo_files = nil
    @bar_files = nil
    FileUtils.rm_rf('foo')
    FileUtils.rm_rf('dot')
  end
end
