case node['platform_family']
when 'windows'
  default['export-node']['path'] = ENV['TEMP']
else
  default['export-node']['path'] = '/opt/kitchen/export-node'
end
default['export-node']['file_name'] = 'chef_node.json'
