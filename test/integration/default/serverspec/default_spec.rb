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

describe file(File.join(ENV['TEMP'] || '/tmp', 'export-node', 'node.json')) do
  let(:parent) { File.join(ENV['TEMP'] || '/tmp', 'kitchen') }
  let(:node) { JSON.parse(IO.read(File.join(parent, 'chef_node.json'))) }

  it { should be_file }
  its(:content) { should match(/^mac: #{node['automatic']['macaddress']}$/) }
end
