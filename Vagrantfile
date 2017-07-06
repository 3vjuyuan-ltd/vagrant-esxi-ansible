# -*- mode: ruby -*-
# vi: set ft=ruby :

require "json"
require "fileutils"
require "digest/md5"
require 'time'

# Check for required plugins and install if missing.
required_plugins = %w(vagrant-triggers vagrant-vsphere)
required_plugins.each do |plugin|
    exec "vagrant plugin install #{plugin} && vagrant #{ARGV.join(" ")}" unless Vagrant.has_plugin? plugin || ARGV[0] == 'plugin'
end

def createVagrantLink()
    FileUtils.rm_rf("./.vagrant")
    projectHomePath = ENV["HOME"]+"/projects/" + File.basename(File.expand_path("..", Dir.pwd)) + '_' + Digest::MD5.hexdigest(Dir.pwd + Time.now.utc.iso8601)[rand(22), 10] + "/.vagrant"
    if !File.directory?(projectHomePath)
        FileUtils.mkpath projectHomePath
    end
    FileUtils.ln_s projectHomePath, ".vagrant"
end

# Create symlink for vagrant files in home path.
if !File.symlink?("./.vagrant")
    createVagrantLink
end

# define deep merge for two hash map
def deep_merge!(target, data)
  merger = proc{|key, v1, v2|
    Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
  target.merge! data, &merger
end

# Load configuration from extenal JSON file
config_data = Hash.new
begin
  deep_merge!(config_data, JSON.parse(File.read(File.join(Dir.pwd, "config.box.json"), encoding:'utf-8')))
rescue Errno::ENOENT
  abort("The configuration file can not be found. Please ensure the file is in the same directory with the name of 'config.box.json'.")
end

Vagrant.configure(2) do |config|
  if config_data['box'] && config_data['box']['name']
    config.vm.box = config_data['box']['name']
  else
    config.vm.box = "dummy.box"
  end
  
  config.vm.synced_folder '.', '/vagrant', disabled: true
  
  if config_data['box'] && config_data['box']['url']
    config.vm.box_url = config_data['box']['url']
  end
    
  config.vm.provider :vsphere do |vs|
    vs.host = config_data['vsphere']['vcenter']
    vs.compute_resource_name = config_data['vsphere']['host']
    vs.data_center_name = config_data['vsphere']['data_center']
    vs.resource_pool_name = config_data['vsphere']['resource_pool']
    vs.data_store_name = config_data['vsphere']['storage']
    vs.template_name = config_data['vsphere']['template']
    vs.vm_base_path = config_data['vsphere']['base_path']
    vs.name = "#{config_data['name']}@#{config_data['project']}.#{config.vm.box}"
    vs.user = config_data['vsphere']['user']
    vs.password = config_data['vsphere']['passwd']
    vs.memory_mb = config_data['vm']['memory']
    vs.cpu_count = config_data['vm']['cpu_count']
    if config_data['vm'].has_key?('vlan')
         vs.vlan = config_data['vm']['vlan']
    end
    vs.insecure = true
  end
  
  # @todo Get guest vm ip and set host file for ansible and windows
  # @todo Configuration in json file and supports multiple playbooks
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
  end
end
