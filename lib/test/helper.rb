##############################################################################
# This module contains helper methods for use within the test cases included
# in this package.  Most of them are cross platform helpers for figuring out
# user names, home directories, etc.
#
# Because we're using test-unit 2, all test files must require this file
# first before requiring test-unit directly.
##############################################################################
require 'rubygems'
require 'pathname'
require 'rbconfig'
require 'fileutils'
require 'test-unit'

module Test
  module Helper
    WINDOWS = RbConfig::CONFIG['host_os'] =~ /windows|mswin|cygwin|mingw|msdos/i ? true : false
    LINUX   = RbConfig::CONFIG['host_os'] =~ /linux/i ? true : false
    SOLARIS = RbConfig::CONFIG['host_os'] =~ /sunos|solaris/i ? true : false
    BSD     = RbConfig::CONFIG['host_os'] =~ /bsd/i ? true : false
    VMS     = RbConfig::CONFIG['host_os'] =~ /vms/i ? true : false
    OSX     = RbConfig::CONFIG['host_os'] =~ /darwin|mach|osx/i ? true : false

    JRUBY    = defined?(JRUBY_VERSION) ? true : false
    RUBINIUS = defined?(Rubinius) ? true : false

    # Neither JRuby nor Rubinius attempt to implement all (or any) $SAFE rules.
    IGNORE_SAFE = JRUBY || RUBINIUS

    if WINDOWS
      MAX_PATH = 260

      require 'Win32API'

      CreateFile  = Win32API.new('kernel32', 'CreateFile', 'PLLPLLL', 'L')
      CloseHandle = Win32API.new('kernel32', 'CloseHandle', 'L', 'I')
      GetUserName = Win32API.new('advapi32', 'GetUserName', 'PL', 'I')
      GetTempPath = Win32API.new('kernel32', 'GetTempPath', 'LP', 'L')
      GetShortPathName = Win32API.new('kernel32', 'GetShortPathName', 'PPL', 'L')
      GetTimeZoneInformation = Win32API.new('kernel32', 'GetTimeZoneInformation', 'P', 'L')
      GetWindowsDirectory = Win32API.new('kernel32', 'GetWindowsDirectory', 'PL', 'L')
      Umask = Win32API.new('msvcrt', '_umask', 'I', 'I')
    else
      require 'etc'
    end

    RELEASE = RUBY_VERSION.split('.').last.to_i

    # This constant is used because of some major behavioral changes between
    # 1.8.6 and 1.8.7 with regards to Enumerators and Symbols.
    major, minor, teeny = RUBY_VERSION.split('.')
    PRE187 = (major.to_i == 1) && (minor.to_i <= 8) && (teeny.to_i <= 6)

    # True if tests are run on a big endian platform
    BIG_ENDIAN = [1].pack('I') == [1].pack('N')

    # True if tests are run in 64-bit mode
    BIT_64 = (2**33).is_a?(Fixnum)

    # True if tests are run in 32-bit mode
    BIT_32 = (2**33).is_a?(Bignum)

    # True if the current process is running as root
    ROOT = Process.euid == 0

    # Returns the base directory of the current file.
    #
    def base_dir(file)
      File.dirname(File.expand_path(file))
    end

    # Returns the base of +path+ with +file+ appended to the end.
    #
    def base_file(path, file)
      File.join(File.dirname(File.expand_path(path)), file)
    end

    # Create an simple file. If +text+ is provided, it's written to the
    # file. Otherwise, an empty file is created.
    #
    def touch(file, text=nil)
      if text
        File.open(file, 'wb'){ |fh| fh.puts text }
      else
        File.open(file, 'wb'){}
      end
    end

    # This uses a native (system) touch command. Used for various File tests
    # where we don't want to use Ruby's own File methods.
    #
    def touch_n(file)
      if WINDOWS
        CloseHandle.call(CreateFile.call(file, 2, 0, 0, 1, 0, 0))
      else
        system("touch #{file}")
      end
    end

    # This uses a native (system) command to retrieve the current directory.
    # I use this where I don't want to use Ruby's Dir.pwd method.
    #
    def pwd_n
      WINDOWS ? `cd`.chomp : `pwd`.chomp
    end

    # Returns the null device for the given platform
    def null_device
      case RbConfig::CONFIG['host_os']
        when /windows|mswin|msdos|cygwin|mingw|win32/i
          'NUL'
        when /amiga/i
          'NIL:'
        when /vms/i
          'NL:'
        else
          '/dev/null'
      end
    end

    # Returns the WINDOWS path on MS Windows. Typically C:/WINDOWS.
    #
    def get_windows_path
      buf = 0.chr * 260
      GetWindowsDirectory.call(buf, buf.length)
      buf.unpack("A*").first.tr('\\','/')
    end

    # Returns the temp folder. On Windows it replaces backslashes with
    # forward slashes, and the trailing slash is removed.
    def get_temp_path
      path = nil
      if WINDOWS
        buf = 0.chr * 260
        GetTempPath.call(buf.length, buf)
        path = buf.unpack("A*").first.tr('\\', '/')
        path.chop! if path[-1,1] == '/'
        path
      else
        path = ENV['TMPDIR'] || ENV['TMP'] || ENV['TEMP'] || '/tmp'
      end
    end

    # Returns the root path. On Windows this is "C:\\". Otherwise it's "/".
    def get_root_path
      WINDOWS ? "C:\\" : "/"
    end

    # Returns the UTF offset/bias.
    def get_tz_offset
      if WINDOWS
        buf = 0.chr * 172
        GetTimeZoneInformation.call(buf)
        buf[0,4].unpack('L')[0] / 60
      else
        offset = `date +%z`.chomp.to_i.abs / 100
        offset += 1 if `date +%Z`.chomp[1].chr == 'D' # DST
        offset
      end
    end

    # Returns the time zone name, e.g. "MST".
    def get_tz_name
      if WINDOWS
        buf = 0.chr * 172
        rv = GetTimeZoneInformation.call(buf)
        if rv == 1
          buf[4,64].tr("\000", '')
        else
          buf[84,64].tr("\000", '')
        end
      else
        `date`.chomp.split[4]
      end
    end

    # This uses a native (system) command or API function to retrieve the
    # current date and time in a [year, mon, dow, day, hour, min, sec, usec]
    # array.
    def get_datetime
      month_name = Hash[
        1,'Jan',2,'Feb',3,'Mar',4,'Apr',5,'May',6,'Jun',7,
        'Jul',8,'Aug',9,'Sep',10,'Oct',11,'Nov',12,'Dec'
      ]

      day_name = Hash[0,'Sun',1,'Mon',2,'Tue',3,'Wed',4,'Thu',5,'Fri',6,'Sat']

      array = []
      if WINDOWS
        buf = 0.chr * 16
        Win32API.new('kernel32', 'GetLocalTime', 'P', 'V').call(buf)
        array.push(
           buf[0,2].unpack('S')[0],
           month_name[buf[2,2].unpack('S')[0]],
           day_name[buf[4,2].unpack('S')[0]],
           buf[6,2].unpack('S')[0],
           buf[8,2].unpack('S')[0],
           buf[10,2].unpack('S')[0],
           buf[12,2].unpack('S')[0],
           buf[14,2].unpack('S')[0]
        )
      else
        temp = `date +'%Y %b %a %d %H %M %S'`.chomp.split
        temp.each_with_index{ |e, i|
           if e =~ /[a-zA-Z]/i
              array[i] = e
           else
              array[i] = e.to_i
           end
        }
        array.push(0) # No nanoseconds
      end
      array
    end

    # Get the user of the current process.
    #
    def get_user
      user = ENV['USERNAME'] || ENV['USER']
      if WINDOWS
        if user.nil?
          buf = 0.chr * MAX_PATH
          if GetUserName.call(buf, buf.length) == 0
            raise "Unable to get user name"
          end
          user = buf.unpack("A*")
        end
      else
        user ||= Etc.getpwuid(Process.uid).name
      end
      user
    end

    # Returns the home directory of the current process owner.
    #
    def get_home
      home = ENV['HOME'] || ENV['USERPROFILE']

      if WINDOWS
        home ||= "C:/Users/" + get_user
      else
        home ||= Etc.getpwuid(Process.uid).dir
      end

      home.tr("\\", "/")
    end

    # Returns the current umask of the process.
    def get_umask
      mask = 0
      if WINDOWS
        omask = Umask.call(0)
        mask = Umask.call(omask)
      else
        mask = `umask`.chomp.to_i
      end
      mask
    end

    def set_umask(val)
      if WINDOWS
        Umask.call(val)
      else
        system("umask #{val}")
      end
    end

    # Removes +file+ in a platform independent manner using system calls.
    # Also handles paths with spaces in them.
    #
    def remove_file(file)
      if WINDOWS
        buf = 0.chr * 260
        GetShortPathName.call(file, buf, buf.size)
        file = buf.unpack("A*").first
        file.tr!('/', '\\')
        system("del /f /q #{file}") if File.exists?(file)
      else
        system("rm -f #{file}") if File.exists?(file)
      end
    end

    # Removes +dir+ in a platform independent manner using system calls.
    # Some extra pain required on Windows because the rmdir doesn't handle
    # forward slashes or spaces very well.
    #
    def remove_dir(dir)
      if WINDOWS
        buf = 0.chr * 260
        dir.tr!('/', "\\")
        if GetShortPathName.call(dir, buf, buf.length) == 0
           raise "Failed to get short path name for: #{dir}"
        end
        short = buf.unpack("A*").first
        system("rmdir /s /q #{short}")
      else
        system("rm -rf #{dir}")
      end
    end
  end
end
