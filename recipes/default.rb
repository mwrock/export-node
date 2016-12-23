ruby_block "Save node attributes" do
  block do
  	parent = node['export-node']['location']
    IO.write(File.join(parent, "chef_node.json"), node.to_json) if Dir::exist?(parent)
  end
end