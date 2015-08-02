#
# Cookbook Name:: syncthing
# Recipe:: default
#
# Do whatever the fuck you want
#

require 'json'
require "net/https"
require "uri"


def get_last_version
    uri = URI.parse("https://api.github.com/repos/syncthing/syncthing/tags")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    data = JSON.parse(response.body)
    data[0]["name"]
end


tag = get_last_version
arch = {
    "x86_64" => "amd64",
    "x86" => "386",
    "armv7l" => "arm",
}[node[:kernel][:machine]]

src = "https://github.com/syncthing/syncthing/releases/download/#{tag}/syncthing-linux-#{arch}-#{tag}.tar.gz"
dst = '/usr/local/lib/syncthing'

version_file = '/var/cache/syncthing.version'
begin
    installed_version = File.read(version_file)
rescue
    installed_version ="0"
end


directory dst do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

tar_extract src do
  target_dir dst
  tar_flags ['--strip-components 1', ]
  only_if { installed_version != tag }
end

link '/usr/local/bin/syncthing' do
    to "#{dst}/syncthing"
end

# add and enable service


file version_file do
  content tag
  mode '0644'
  owner 'root'
  group 'root'
end
