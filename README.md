vagrant-esxi-ansible
====
Vagrant box and configuration with esxi as provider and ansible as provision

## Configuration
This provider has the following settings, all are required unless noted:
* host - IP or name for the vSphere API
*	compute_resource_name - Required if cloning from template the name of the host or cluster containing the resource pool for the new VM
*	data_center_name - Optional datacenter containing the computed resource, the template and where the new VM will be created, if not specified the first datacenter found will be used
*	resource_pool_name - the resource pool for the new VM. If not supplied, and cloning from a template, uses the root resource pool
*	data_store_name - Optional the datastore where the VM will be located
*	template_name - the VM or VM template to clone (including the full folder path)
*	vm_base_path - Optional path to folder where new VM should be created, if not specified template's parent folder will be used
*	name - Optional name of the new VM, if missing the name will be auto generated
*	user - user name for connecting to vSphere
*	password - password for connecting to vSphere. If no value is given, or the value is set to :ask, the user will be prompted to enter the password on each invocation.
*	memory_mb - Optional Configure the amount of memory (in MB) for the new VM
*	cpu_count - Optional Configure the number of CPUs for the new VM
*	vlan - Optional vlan to connect the first NIC to
*	insecure - Optional verify SSL certificate from the host
