dir = node['export-node']['path']

directory dir

file File.join(dir, node['export-node']['file_name']) do
  content 'mac: #{node[\'macaddress\']}'
end
