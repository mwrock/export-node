require 'json'
require 'serverspec'

set :backend, :exec

describe file("/var/node.json") do
  let(:node) { JSON.parse(IO.read('/tmp/kitchen/chef_node.json')) }

  it { should be_a_file }
  its(:content) {
    should eq "mac: #{node["automatic"]["macaddress"]}"
  }
end