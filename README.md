# export-node

export-node exports node attributes to a json file so that it can be retrieved from a kitchen test.

## Usage

Add the export-node cookbook to the end of the runlist in your kitchen suites:

```yaml
suites:
  - name: my-suite
    run_list:
      - recipe[cookbook-under-test]
      - recipe[export-node]
```

Now your tests can access any node attribute by parsing the file's json to a hash:

```ruby
describe file('/etc/haproxy/haproxy.cfg') do
  let(:node) { JSON.parse(IO.read('/tmp/kitchen/chef_node.json')) }
  let(:subnet) {
    ip = node["automatic"]["ipaddress"]
    ip[0,ip.rindex(".")]
  }
  let(:current_env) { node["chef_environment"].upcase}

  it { should be_a_file }
  its(:content) {
    should match <<-EOS
        backend elasticsearch_backend
            mode http
            balance roundrobin
            server #{current_env}SEARCH01 #{subnet}.121:9200 weight 1 check port 9200
            server #{current_env}SEARCH02 #{subnet}.122:9200 weight 1 check port 9200
            server #{current_env}SEARCH03 #{subnet}.123:9200 weight 1 check port 9200


        backend web_backend
            mode http
            balance roundrobin
            timeout server 5m
            server #{current_env}WEB01 #{subnet}.131:80 weight 1 check port 80
            server #{current_env}WEB02 #{subnet}.132:80 weight 1 check port 80


        backend rabbit_backend
            mode http
            balance roundrobin
            server #{current_env}RABBIT01 #{subnet}.141:15672 weight 1 check port 15672
            server #{current_env}RABBIT02 #{subnet}.142:15672 weight 1 check port 15672
            server #{current_env}RABBIT03 #{subnet}.143:15672 weight 1 check port 15672
    EOS
  }
end
```
