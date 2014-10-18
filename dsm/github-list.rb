#!/usr/bin/env ruby
#
# List repositories of a given user and all its public organizations
# on standard output using the GitHub API
#
#     github-list.rb USERNAME
#
#     > username/repo1
#     > username/repo2
#     > username/repo3
#     > organisation1/repo1
#     > organisation1/repo2
#     > organisation2/repo3

require 'base64'
require 'json'
require 'open-uri'

GITHUB_API_VERSION = "v3"
GITHUB_API_URL = "https://api.github.com/"
GITHUB_API_ACCEPT = "application/vnd.github.#{GITHUB_API_VERSION}+json"
GITHUB_API_HEADERS = {
  'Accept' => GITHUB_API_ACCEPT#,
  # TODO 'Authorization' => "Basic #{Base64.encode64('username:password')}"
}

# Check argument numbers
if ARGV.count != 1
  abort "Syntax: #{File.basename($0, File.extname($0))} USERNAME"
end
username = ARGV[0]

def display_repositories(entity)
  repos = JSON.parse(open(entity['repos_url'], GITHUB_API_HEADERS).read)
  repos.each do |repo|
    puts repo['full_name']
  end
end

begin

  # Connect to GitHub API and get user organization url
  urls = JSON.parse(open(GITHUB_API_URL, GITHUB_API_HEADERS).read)

  # Fetch user and get his URLs
  user = JSON.parse(open(urls['user_url'].sub('{user}', username), GITHUB_API_HEADERS).read)

  # User repositories
  display_repositories user

  # Fetch user and get his URLs
  orgs = JSON.parse(open(user['organizations_url'], GITHUB_API_HEADERS).read)

  # Iterate over organizations
  orgs.each do |org|
    display_repositories org
  end

rescue OpenURI::HTTPError => e
  case e.io.status[0]
  when "403"
    abort JSON.parse(e.io.string)['message']
  when "404"
    abort "Unknown user #{username}"
  else
    abort "GitHub is unreachable (#{e.io.status[0]} #{e.io.status[1]})"
  end
rescue JSON::ParserError => e
  abort "GitHub response unreadable: #{e}"
rescue Exception => e
  abort "Unexpected exception: #{e}"
end
