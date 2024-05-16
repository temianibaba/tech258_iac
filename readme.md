# Infrastructure as Code
## Definition
Helps us codify anything and everything, it helps us write a language that we can read and understand to instruct machines to execute tasks accordingly.<br>
Automating, managing and orchestrating the launching and scaling of cloud services.

## Benefits
If we have 100 instance that all need nginx on them I have the knowledge and the capacity to achieve this goal, however it would take some time. IaC speeds up this process.

## Why Ansible
- **Open source(free)**<Br>
- **Simple to use(YAML)**<br>
    **Simple Language (YAML):** Ansible uses YAML for its playbooks, which is easy to read and write. This lowers the barrier to entry for new users and allows non-developers to understand and contribute to automation tasks.<br>
    **Declarative Configuration:** Users declare the desired state of the system, and Ansible ensures it is achieved. This reduces the complexity involved in scripting and imperative programming.<br>
- **Powerful**<br>
    **Comprehensive Modules:** Ansible provides a vast library of modules for managing a wide range of system tasks, from package installation to cloud provisioning. This extensibility makes it versatile for different environments.<br>
**Idempotency:** Ansible ensures that running a playbook multiple times will produce the same result, preventing unintended changes and ensuring system stability.<br>
- **Agentless**<br>
    **No Agents Required:** Ansible operates without the need for agents or daemons on managed nodes. It uses standard SSH for Unix-like systems and WinRM for Windows systems. This simplifies setup and reduces maintenance overhead.<br>
    **Security:** Leveraging existing, secure protocols (SSH/WinRM) means fewer security concerns related to running additional software on managed nodes.<br>
## How Ansible works
Control Node: The system where Ansible is installed and from which commands are run.<br>
Managed Nodes: The systems that Ansible manages, also known as target systems or hosts.<br>
Ansible uses an inventory file to define the list of managed nodes. This file can be in various formats such as INI, YAML, or dynamic inventory scripts.<br>
Modules are the units of work in Ansible. They are scripts that perform specific tasks like installing packages, managing services, or handling files. Ansible comes with a large number of built-in modules, and users can write custom ones.<br>
![alt text](images/inside_ansible.png)<br>
**Playbooks** are YAML files that define a series of tasks to be executed on the managed nodes. They allow for complex configurations and workflows, specifying the desired state of the systems.<br>
**Setup**<br>
After install ansible on your instance you have to move your private ssh key into your instance and configure the hosts file so that ansible knows where the key is to ssh into other instances
```bash
[agent_nodes]
web ansible_host=34.254.90.199
db ansible_host=54.246.172.14
 
[agent_nodes:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/tech258.pem

# or

[web]
ec2-instance-app ansible_host=54.216.9.103 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/tech258.pem
```

## Why Terraform