ruby_block 'Save node attributes' do
  block do
    parent = node['export-node']['path']
    FileUtils.mkpath parent
    IO.write(File.join(parent, node['export-node']['file_name']), node.to_json) if Dir.exist?(parent)
  end
end
