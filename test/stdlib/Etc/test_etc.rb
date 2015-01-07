###############################################################################
# test_etc.rb
#
# Tests for the Etc module. This test case goes out of its way to avoid using
# the Test::Helper module because that module uses Etc internally. Thus, I
# want to avoid using Etc to test itself. :)
#
# Note that these tests should not be run on MS Windows.
#
# TODO: Need some group member tests.
###############################################################################
require 'test/unit'
require 'rbconfig'
require 'etc'

class Test_Stdlib_Etc < Test::Unit::TestCase
  WINDOWS = File::ALT_SEPARATOR

  def setup
    @login = `whoami`.chomp
    @name  = RbConfig::CONFIG['host_os'] =~ /darwin|osx/i ? 'mailman' : @login

    unless File::ALT_SEPARATOR
      @group = IO.readlines('/etc/group').grep(/sys:/i).first.chomp.split(':')
      @user  = IO.readlines('/etc/passwd').grep(/#{@name}/i).first.chomp.split(':')

      # Some platforms use a double colon for the first separator, so we need
      # to delete any empty elements that appear as a result of this.
      @group.delete_if{ |e| e == "" || e == "*" }
      @user.delete_if{ |e| e == "" || e == "*" }

      @group_name = @group[0]
      @group_id   = @group[2].to_i
      @group_mem  = @group[3]

      @user_name = @user[0]
      @user_id   = @user[2].to_i
    end

    @pwent  = nil
    @pwent2 = nil
    @grent  = nil
    @grent2 = nil
  end

  test "endgrent basic functionality" do
    assert_respond_to(Etc, :endgrent)
    assert_nothing_raised{ Etc.endgrent }
  end

  test "endgrent returns nil" do
    assert_nil(Etc.endgrent)
  end

  test "endpwent basic functionality" do
    assert_respond_to(Etc, :endpwent)
    assert_nothing_raised{ Etc.endpwent }
  end

  test "endpwent returns nil" do
    assert_nil(Etc.endpwent)
  end

  test "getgrent basic functionality" do
    assert_respond_to(Etc, :getgrent)
    assert_nothing_raised{ Etc.getgrent }
  end

  test "getgrent returns a single Group struct" do
    omit_if(WINDOWS)
    assert_kind_of(Struct::Group, Etc.getgrent)
  end

  test "getgrent returns nil on Windows" do
    omit_unless(WINDOWS)
    assert_nil(Etc.getgrent)
  end

  test "struct returned by getgrent has three members" do
    omit_if(WINDOWS)
    @grent = Etc.getgrent
    assert_respond_to(@grent, :name)
    assert_respond_to(@grent, :gid)
    assert_respond_to(@grent, :mem)
  end

  test "struct members returned by getgrent are of the expected type" do
    omit_if(WINDOWS)
    @grent = Etc.getgrent
    assert_kind_of(String, @grent.name)
    assert_kind_of(Integer, @grent.gid)
    assert_kind_of(Array, @grent.mem)
  end

  test "getgrgid basic functionality" do
    assert_respond_to(Etc, :getgrgid)
    assert_nothing_raised{ Etc.getgrgid(@group_id) }
  end

  test "getgrgid returns a Group struct" do
    assert_kind_of(Struct::Group, Etc.getgrgid(@group_id))
  end

  test "getgrgid returns the expected struct values" do
    @grent = Etc.getgrgid(@group_id)
    assert_equal(@group_name, @grent.name)
    assert_equal(@group_id, @grent.gid)
  end

  test "getgrnam basic functionality" do
    assert_respond_to(Etc, :getgrnam)
    assert_nothing_raised{ Etc.getgrnam('sys') }
  end

  test "getgrnam returns a Group struct" do
    assert_kind_of(Struct::Group, Etc.getgrnam('sys'))
  end

  test "getgrnam returns the expected struct values" do
    @grent = Etc.getgrnam('sys')
    assert_equal(@group_name, @grent.name)
    assert_equal(@group_id, @grent.gid)
  end

  test "getlogin basic functionality" do
    assert_respond_to(Etc, :getlogin)
    assert_nothing_raised{ Etc.getlogin }
  end

  test "getlogin returns expected value" do
    assert_kind_of(String, Etc.getlogin)
    assert_equal(@login, Etc.getlogin)
  end

  test "getpwent basic functionality" do
    assert_respond_to(Etc, :getpwent)
    assert_nothing_raised{ Etc.getpwent }
  end

  test "getpwent returns a single Passwd struct" do
    assert_kind_of(Struct::Passwd, Etc.getpwent)
  end

  test "Passwd struct returned by getpwent has expected members" do
    @pwent = Etc.getpwent
    assert_respond_to(@pwent, :name)
    assert_respond_to(@pwent, :uid)
    assert_respond_to(@pwent, :gid)
    assert_respond_to(@pwent, :dir)
    assert_respond_to(@pwent, :shell)
  end

  test "Passwd struct are of the expected type" do
    @pwent = Etc.getpwent
    assert_kind_of(String, @pwent.name)
    assert_kind_of(Integer, @pwent.uid)
    assert_kind_of(Integer, @pwent.gid)
    assert_kind_of(String, @pwent.dir)
    assert_kind_of(String, @pwent.shell)
  end

  test "getpwnam basic functionality" do
    assert_respond_to(Etc, :getpwnam)
    assert_nothing_raised{ Etc.getpwnam(@login) }
  end

  test "getpwnam returns Passwd struct" do
    assert_kind_of(Struct::Passwd, Etc.getpwnam(@login))
  end

  test "getpwnam returns expected Passwd struct" do
    @pwent = Etc.getpwnam(@login)
    assert_equal(@login, @pwent.name)
  end

  test "getpwuid basic functionality" do
    assert_respond_to(Etc, :getpwuid)
    assert_nothing_raised{ Etc.getpwuid(@user_id) }
  end

  test "getpwuid returns a Passwd struct" do
    assert_kind_of(Struct::Passwd, Etc.getpwuid(@user_id))
  end

  test "getpwuid returns expected Passwd struct" do
    @pwent = Etc.getpwuid(@user_id)
    assert_equal(@name, @pwent.name)
  end

  test "group method basic functionality" do
    assert_respond_to(Etc, :group)
    assert_nothing_raised{ Etc.group }
  end

  test "group method returns a Group struct" do
    assert_kind_of(Struct::Group, Etc.group)
  end

  test "group method without a block reads one entry at a time" do
    assert_not_equal(Etc.group.name, Etc.group.name)
  end

  test "group method with a block resets back to the first entry" do
    assert_nothing_raised{ Etc.group{ |g| @grent  = g; break } }
    assert_nothing_raised{ Etc.group{ |g| @grent2 = g; break } }
    assert_equal(@grent, @grent2)
  end

  test "group method does not accept any arguments" do
    assert_raise(ArgumentError){ Etc.group(1) }
  end

  test "group returns nil if already at end of the database" do
    assert_nothing_raised{ 1000.times{ Etc.group } }
    assert_nil(Etc.group)
    Etc.setgrent
  end

  test "passwd basic functionality" do
    assert_respond_to(Etc, :passwd)
    assert_nothing_raised{ Etc.passwd }
  end

  test "passwd returns a Passwd struct" do
    assert_kind_of(Struct::Passwd, Etc.passwd)
  end

  test "passwd method without a block reads one entry at a time" do
    assert_true(Etc.passwd.name != Etc.passwd.name)
  end

  test "passwd method with a block resets back to the first entry" do
    assert_nothing_raised{ Etc.passwd{ |pw| @pwent  = pw; break } }
    assert_nothing_raised{ Etc.passwd{ |pw| @pwent2 = pw; break } }
    assert_equal(@pwent, @pwent2)
  end

  test "passwd method does not accept any arguments" do
    assert_raise(ArgumentError){ Etc.passwd(1) }
  end

  test "passwd returns nil if already at end of the database" do
    assert_nothing_raised{ 1000.times{ Etc.passwd } }
    assert_nil(Etc.passwd)
    Etc.setpwent
  end

  test "setgrent basic functionality" do
    assert_respond_to(Etc, :setgrent)
    assert_nothing_raised{ Etc.setgrent }
  end

  test "setgrent returns nil" do
    assert_nil(Etc.setgrent)
  end

  test "setgrent rewinds to the start of the database" do
    @grent = Etc.group
    Etc.setgrent
    @grent2 = Etc.group
    assert_equal(@grent, @grent2)
  end

  test "setgrent does not accept any arguments" do
    assert_raise(ArgumentError){ Etc.setgrent(1) }
  end

  test "setpwent basic functionality" do
    assert_respond_to(Etc, :setpwent)
    assert_nothing_raised{ Etc.setpwent }
  end

  test "setpwent returns nil" do
    assert_nil(Etc.setpwent)
  end

  test "setpwent rewinds to the start of the database" do
    @pwent = Etc.passwd
    Etc.setpwent
    @pwent2 = Etc.passwd
    assert_equal(@pwent, @pwent2)
  end

  test "setpwent does not take any arguments" do
    assert_raise(ArgumentError){ Etc.setpwent(1) }
  end

  def teardown
    @login  = nil
    @name   = nil
    @pwent  = nil
    @pwent2 = nil
    @grent  = nil
    @grent2 = nil
    @group  = nil
    @user  = nil
  end
end
