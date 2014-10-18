#!/usr/bin/env ruby
#
# Clone all repositories of a given user into a given path.
# If a git repository already exists in the current location,
# it will be updated using git pull
#
#     github-list.rb USERNAME PATH
#
#     PATH/username/repo1/
#     PATH/username/repo2/
#     PATH/username/repo3/
#     PATH/organisation1/repo1/
#     PATH/organisation1/repo2/
#     PATH/organisation2/repo3/
#
# Note: this script require ./github-list.rb

# Check argument numbers
if ARGV.count != 2
  abort "Syntax: #{File.basename($0, File.extname($0))} USERNAME PATH"
end
username = ARGV[0]

# Check path
path = ARGV[1]
abort "Directory #{path} does not exits" if !File.exists? path
abort "#{path} is not a directory"       if !File.directory? path
abort "#{path} is not writable"          if !File.writable? path

begin

  # Get all repos using github-list.rb
  repos = `#{File.dirname(__FILE__) + '/github-list.rb ' + username}`

  # Iterate over all fetched repos
  repos.split("\n").each do |repo|

    repo_owner, repo_name = repo.split('/')
    full_path = File.join path, repo_owner, repo_name, '.git'
    repo_url = "https://github.com/#{repo}.git"

    if File.exists? full_path

      # Check that directory
      abort "Directory #{full_path} exists but is not a directory" if !File.directory? path
      abort "Directory #{full_path} exists but is not writable"    if !File.writable? path

      # Update the local mirror from GitHub
      puts "Updating #{full_path}... "
      puts `cd "#{full_path}" && git fetch --all`
      puts "Done"

    else

      # Clone the repo
      puts `git clone --mirror https://github.com/amercier/grunt-php.git "#{full_path}"`

    end

  end

rescue Exception => e
  abort "#{e}"
end
