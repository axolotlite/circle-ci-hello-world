# Udacity Advanced DevOps Nanodegree
This repo is part of the projects included in this nanodegree, specifically:
Build CI/CD Pipelines, Monitoring & Logging; Lesson 4

## Deploy and Configure an EC2 instance using Circleci + Ansible

### Directories
```
└── template.yml
├── ansible.cfg
├── inventory
├── main.yml
└── roles
│   └── setup
│       ├── files
│       │   └── index.js
│       └── tasks
│           └── main.yml
└── .circleci
    └─── config.yml 
```

### Main Directory
it contains the main ansible-playbook, a cloudformation template designed to launch an EC2 instance
and an ansible config file that prevents ansible from asking for approval when dealing with a new SSH target.

### Playbook Roles
Currently there is only one role, setup.
It installs both nodejs and npm, then installs pm2 through them.
After finishing with the installation
They move "index.js" from files into a newly created folder called "web" in the home directory.

### Circleci Config
It contains 3 executors (node, aws-cli and alpine).
One of which have been used to provision an EC2 instance, await its completion then create a file containing its all available Public IP addresses to Circleci cache.(aws-cli)
Another install ansible alongside its dependencies, attaches the workspace and activates the playbook configuring the infrastructure.(alpine)
