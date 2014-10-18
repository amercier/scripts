#!/usr/bin/env ruby
#
# List repositories of a given user and all its public organizations
# on standard output using the GitHub API
#
#     github-list.rb USERNAME LOGIN:PASSWORD
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
require 'pp'

# Check argument numbers
if ARGV.count != 2
  abort "Syntax: #{File.basename($0, File.extname($0))} USERNAME LOGIN:PASSWORD"
end
username = ARGV[0]

GITHUB_API_VERSION = "v3"
GITHUB_API_URL = "https://api.github.com/"
GITHUB_API_ACCEPT = "application/vnd.github.#{GITHUB_API_VERSION}+json"
GITHUB_API_HEADERS = {
  'Accept' => GITHUB_API_ACCEPT,
  'Authorization' => "Basic #{Base64.encode64(ARGV[1])}"
}

# Parses a RFC5988-compliant link header value and return a hash
#
# Params:
# +links+:: comma-separated list of links. A link is is a string in the format: <+value+>; rel="+key+"
#
# Returns a hash using +key+ as keys and +value+ as values
#
# See http://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api#pagination
# to see concrete example of pagination using the link header
# See RFC5988 reference documentation at http://tools.ietf.org/html/rfc5988#section-5
def parse_links(links)
  results = Hash.new
  links.split(/, */).each do |part|
    if !(matches = /\A<(.*)>; [^=]+="([^"]*)"\Z/.match(part)).nil?
      results[ matches[2] ] = matches[1]
    end
  end
  return results
end

# Display all GitHub repositories of a user or an organization
#
# Params:
# +entity+:: user or organization identifier
#
# Returns void
def display_repositories(entity)

  url = entity['repos_url']
  while !url.nil?
    response = open(url, GITHUB_API_HEADERS)

    # Parse repositories
    repos = JSON.parse response.read
    repos.each do |repo|
      puts repo['full_name']
    end

    # Check if there is a next page
    url = nil
    if response.meta.has_key? 'link'
      links = parse_links response.meta['link']
      url = links['next'] if links.has_key? 'next'
    end
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
  when "401", "403"
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
