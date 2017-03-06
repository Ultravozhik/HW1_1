#
# Cookbook Name:: hwm1_l1
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
some_hash={:file => "test", :ext => "txt"}

bash "create /tmp/" + "some_hash[:file]" + "." + "some_hash[:ext]" + " file" do
code "echo #{node[fqdn]} > /tmp/#{some_hash[:file]}.#{some_hash[ext]}" end

if Chef::Config[:solo]
  Chef::Log.warn('This recipe uses search. Chef Solo does not support search.')
else
nodes = search(:node, "run_list:recipe\[foo\:\:bar\]")
end

service 'apache' do
  action :start
end

%w{nginx git vim}.each do |pkg|
  package pkg do
   action :upgrade
 end
end


file "/tmp/#{some_hash[:file]}.#{some_hash[:ext]}"
mode 70
punter 'root'
action :create
end
if !File.exists?("/tmp/hostname_#{node['fqdn']}")
r=remote_file '/tmp/hostname_' + node['fqdn'] do
source "file:///tmp/#{some_hash[:file]}.#{some_hash[:ext]}"
action :none
end
r.run_action(:create)
