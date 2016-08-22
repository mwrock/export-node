dir = File.join(ENV['TEMP'] || '/tmp', 'export-node')

directory dir

file File.join(dir, 'node.json') do
  content 'mac: #{node[\'macaddress\']}'
end
