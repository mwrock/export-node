ruby_block "Save node attributes" do
  block do
    IO.write("/tmp/kitchen/chef_node.json", node.to_json) if Dir::exist?('/tmp/kitchen')
  end
end