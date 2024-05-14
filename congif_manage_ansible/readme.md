# Ansible
![alt text](../images/ansible.png)

1. Create ec2 run update upgrade
```bash
2. sudo apt-get install software-properties-common
3. sudo apt-add-repository ppa:ansible/ansible
4. sudo apt-get update -y
5. sudo apt-get install ansible -y
6. sudo ansible --version
7. cd /etc/ansible (where we run commands)
8. ls ----> ansible.cfg hosts roles
app machine = web db machine = db
9. sudo ansible web -m ping
10.  sudo nano hosts
app ip 34.254.90.199 db ip 54.246.172.14
11.  sudo ansible web -m ping
12.  scp key into .ssh folder scp -i ~/.ssh/tech258.pem ~/.ssh/tech258.pem ubuntu@34.248.241.223:~/.ssh/
13.  sudo chmod 400 "tech258.pem"
14.  can now ssh into app or db from controller
15.  cd /etc/ansible
16.  provide address of key in hosts file
[agent_nodes]
web ansible_host=34.254.90.199
db ansible_host=54.246.172.14
 
[agent_nodes:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/tech258.pem


```