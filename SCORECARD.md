A list of bugs and other things discovered as a result of this test suite, either directly or indirectly.

# Bugs

## Core
* Dir.chdir and '/'. See ruby-core: 8914.
* String#slice! documentation. See ruby-core: 9754.
* String#upto infinite loop bug. See ruby-core: 9864.
* Process::GID#eid= and Process::UID#eid= aliases. See ruby-core: 11022.
* Array#== and custom to_ary methods. See RubyForge bug #11585.
* IO.read handle leak on failed reads. See RubyForge bug #15065.
* SignalException#signo bug. See RubyForge bug #11795.
* Array#flatten!(0) should return nil. See Ruby 1.8-Bug#4196.
* Process.maxgroups is implemented poorly and Process.maxgroups= has no use
  case. It isn't backed by an actual POSIX call, making it useless since the
  OS wouldn't enforce it anyway. Redmine bug #4467.

## Core (Indirectly)
* Bug in eval.c where rb_define_alias could fail. See ruby-talk:279538.
* Almost all of Ruby's "aliases" will fail a Method#== check because they're
  declared internally as synonyms instead of aliases. See ruby-core: 13301.

## Stdlib
* Etc.getgrgid broken. Independently verified ruby-dev: 30586.

## Quirks, Inconsistencies and Other Stuff
* Math.atanh(1), and similar edge cases, raise different errors on different
  platforms (ERANGE vs EDOM). On MS Windows, no error is raised and Infinity
  is returned instead. See ruby-core: 10174.
* Some methods raise ArgumentError when they probably ought to return
  TypeError. Ruby is inconsistent on this, even within the same method. For
  example, ['test'].pack('C') raises a TypeError, while ['test'].pack('D')
  raises an ArgumentError. Many of these can be traced to the Integer() and
  Float() kernel methods.
* Some methods, such as File.join, let you pass no arguments when they
  probably ought to check for 0 arguments and raise an ArgumentError. At the
  moment they're just no-ops.
* The chsize() function in MS VC++ 6.0 has a bug where it does not raise an
  error if you pass a negative value for the size argument. This affects the
  File.truncate method, i.e. it's a no-op instead of raising an error. MS
  VC++ 8.0 fixes this bug.
* Problems with File and File::Stat caused by an underlying bug in the
  Solaris stat() function, where the st_size member wasn't set properly.
  See ruby-core: 9926.
* Array#fill and negative indices. See ruby-core:12950.

## From Left Field
* The documentation for the IO#clone method in "Programming Ruby, 2nd ed." is,
  as far as I can tell, totally false. There may have once been a separate
  implementation for IO#clone in io.c at some point but, if there was, there's
  no mention of its removal in the ChangeLog. In any case, the IO objects do NOT
  share a common file pointer. IO just uses the inherited Object#clone method,
  and dup's the file pointer.

## JRuby, Rubinius, Truffleruby, etc
  The majority of the bugs reported by me for other implementations of Ruby
  are the direct result of this test suite. For JRuby, that's over 100 bug
  reports at this point.
