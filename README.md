## Description
This is a custom test suite for Ruby. It includes tests for both the core
classes and the standard library. A series of benchmarks are also included.

## WARNING
This is my personal test suite for Ruby. There are many like it, but this one
is mine. I am not interested in comments, opinions or pull requests unless
I specifically request them.

## CURRENT STATUS
This project is effectively defunct, as my interest in working on it any
longer is effectively dead. It was interesting to work on back when Ruby had
a horrible set of tests and there was some value to writing specs for other
implementations to conform to, but I think days are now long past.

I will leave this repo up for historical purposes, but in an archived state.
You are free to copy any bits that find useful.

[Note that I may sometimes temporarily unarchive it to putter about.]

## Prerequisites
* rake 0.9.2 or later.
* test-unit 2.4 or later.
* mkmf-lite

## Installation
There is no gem. Just clone and run.
A gemspec is provided for Bundler users.

## First Rule
The first rule of berger_spec is that no one passes berger_spec.

Seriously, no one passes all the specs because there are small inconsistencies
and problems in MRI that are either copied by other implementations, in which
case they are wrong, too. Or, they're fixed in the other implementations, which
means they don't match MRI. Catch 22, baby.

## Conventions

### Directory Layout
* bench - toplevel directory for all benchmarks
* test  - toplevel directory for all tests
   
* bench/core   - toplevel directory for benchmarks of core Ruby methods.
* bench/stdlib - toplevel directory for benchmarks of libraries in the stdlib.
* test/core    - toplevel directory for tests of core Ruby classes.
* test/stdlib  - toplevel directory for tests of stdlib.
* test/lib     - contains helper modules that can be used in your test cases.
   
Under `test/core` there is a folder for each of the core classes. Under
those folders are one or two subdirectories - `singleton` and/or `instance`.
   
Under the `singleton` folders are the tests for the class methods of the
class in question. Under the `instance` folders are the tests for the instance
methods of the class in question, if applicable.
   
## Test suites
The test program shall be `test-unit 2`.

All test files shall start with "test_", and end with the name of the method,
or an analogue based on the internal method name, e.g. "aref" to refer to
`Array#[]`.
   
All test class names shall start with "Test_", followed by the class name,
followed by the class or instance method (capitalized), followed by the word
"SingletonMethod" or "InstanceMethod", as appropriate.
   
For example, `Test_Dir_Getwd_SingletonMethod < Test::Unit::TestCase`

The `Test::Helper` module is mandatory in all tests, and must be
required in all test files.
 
Running the tests should be handled via tasks in the Rakefile. Some tests
are skipped on certain platforms. Other tests are skipped unless you run
the tests as root. Still others are skipped for alternate implementations,
such as JRuby.
   
## Testing guidelines for writers
* One test file per method for the core classes. Exception: it is not necessary
  to create separate files for aliases, but aliases should be tested.
* Comment your tests as appropriate.
* Test basic functionality using most likely real world uses.
* Test for expected errors.
* Test edge cases (nil, 0, true, false, empty string).
* Validate `$SAFE` behavior if appropriate.
* Validate taint behavior if appropriate.
* Go out of your way to break things. :)
   
Any bugs found as a result of the test suite should be marked in the `SCORECARD`.
   
## Coding guidelines for writers
* Two space indentation.
* Tabs to spaces, always.
* Meaningful test names and/or descriptions.
* Avoid tests that depend on other tests.
* Always reset your instance variables to nil in the teardown method.
* Ditto for class variables in the shutdown method.
* Use the `Test::Helper` methods where appropriate.

## Branches
Each major release of Ruby will have its own branch. I do not make separate
branches for point/teeny releases.

Once a new major release of Ruby is released, I do not go back and work
on older branches.

## Benchmark suites
The benchmark library shall be "benchmark", the library that comes bundled
as part of the Ruby standard library.

All benchmark programs shall start with "bench_", and end with the name of
the class.  There shall be one benchmark program per class, although
benchmark suites are also allowed per method, if desired. I have created
a few method benchmarks in order to compare changes to the C source with
original source code.

## Notes on the Benchmark suite
The purpose of the benchmark suite is to determine overall speed, perform
speed comparisons between minor releases, high iteration testing, look for
any pathological slowdowns, and to find methods that can be optimized.
   
## Running the tests
Use the Rake tasks to run the various tests. You can run the individual
test suites by using the name of the class or package, e.g. `rake
test:core:array`.
  
To perform all core tests run `rake test:core`. Likewise, to perform all
of the stdlib tests run `rake test:stdlib`.
 
To perform all tests run `rake test`.

See the output of `rake -T` to see all available tests.

## On JRuby
As of 25-May-2007 I've decided to go ahead and tailor some of the tests
for JRuby. This is easy enough to do by checking the value of the JRUBY
constant (defined in the Test::Helper module). You will have to stay
somewhat apprised of JRuby development to know what tests can and/or
should be skipped. Generally speaking this means $SAFE tests, and some of
the Process methods.
   
## Miscellaneous
The Object and Kernel methods are separated in the same manner as the
Pickaxe breaks them out, for clarity.

## TODO
Many of the individual tests have 'TODO' markers in them to indicate that
more and/or better tests need to be added.

Obviously, any method that hasn't been tested is a 'TODO' item.

## Acknowledgements
Some tests shamelessly plagiarized from rubyspec, Rubicon, Rubinius,
BFTS, or the JRuby test suite.

## License
Artistic-2.0

## Warranty
This package is provided "as is" and without any express or
implied warranties, including, without limitation, the implied
warranties of merchantability and fitness for a particular purpose.

## Author
Daniel J. Berger
