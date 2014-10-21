#!/usr/bin/env ruby
#
# Download and installs a software packaged as a .dmg file containing a .app
# folder.
#
#     install-app.rb URL APPLICATION_NAME

require 'pathname'
require 'tmpdir'

# Check argument numbers
if ARGV.count != 2
  abort "Syntax: #{File.basename($0, File.extname($0))} URL APPLICATION_NAME"
end
url = ARGV[0]
application_name = ARGV[1]

# Check if application is already installed
if File.exists?("/Applications/#{application_name}.app")
  abort "#{application_name} is already installed"
end

begin

  Dir.mktmpdir do |tmpdir|
    dmg = Pathname.new "#{tmpdir}/#{application_name}.dmg"

    puts "Downloading #{application_name}"
    `curl -L# #{url.sub(' ','%20')} -o #{dmg}`

    puts "Mounting #{dmg.basename.sub(' ', '\\ ')}"
    mount_point = Pathname.new "#{tmpdir}/#{application_name}"
    `hdiutil attach -mountpoint #{mount_point} #{dmg}`

    # Find any apps in the mounted dmg
    files = mount_point.entries.collect { |file| mount_point + file }
    files.reject! { |file| ((file.to_s.include?(".app")) ? false : true) }

    # Install all .app files
    files.each do |app|
      puts "Copying #{app.basename.sub(' ', '\\ ')} to Applications folder"
      `cp -a #{app} /Applications/`
    end

    # Unmount the .dmg
    puts "Unmounting #{dmg.basename.sub(' ', '\\ ')}"
    result = `hdiutil detach #{mount_point}`
    puts "Finished installing #{application_name}"
  end

rescue Exception => e
  abort "#{e}"
end
