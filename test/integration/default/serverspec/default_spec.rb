require 'json'
require 'serverspec'

require 'rbconfig'
case RbConfig::CONFIG['host_os']
when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
  set :backend, :cmd
  set :os, family: 'windows'
else
  set :backend, :exec
end

export_path = :os.family == 'windows' ? '/opt/kitchen/export-node' : ENV['TEMP']

file_name = File.join(export_path, 'chef_node.json')

describe file(file_name) do
  let(:node) { JSON.parse(IO.read(file_name)) }
  it { should be_file }
  its(:content) { should match(/^mac: #{node['automatic']['macaddress']}$/) }
end
