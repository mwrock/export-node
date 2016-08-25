
 
default['export-node']['path'] = ENV['TEMP']
default['export-node']['path'] = '/opt/kitchen/export-node' unless node['platform_family'] == 'windows'

default['export-node']['file_name'] = 'chef_node.json'
