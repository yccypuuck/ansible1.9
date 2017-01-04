# About this Repo

This repository provides Dockerfile which provides Ansible 1.9 + few additional libraries.
 * https://hub.docker.com/r/peru/ansible1.9/

## Usage

You can run it like this:

```
ANSIBLE_VAULT_PASSWORD_FILE=${ANSIBLE_VAULT_PASSWORD_FILE:-"~/.ansible/vault.password"}

DOCKER_PARAMETERS="
  run --interactive --tty --rm \
  --env SSH_AUTH_SOCK=/ssh-agent \
  --env ANSIBLE_VAULT_PASSWORD_FILE=$ANSIBLE_VAULT_PASSWORD_FILE \
  --volume $(readlink -f $SSH_AUTH_SOCK):/ssh-agent \
  --volume $HOME/.aws:/home/ansible/.aws:ro \
  --volume $HOME/.ansible:/home/ansible/.ansible:ro \
  --volume $HOME/.ansible/tmp:/home/ansible/.ansible/tmp \
  --volume $HOME/.ansible/cp:/home/ansible/.ansible/cp \
  --volume $PWD:/home/ansible/ansible_project:ro \
  --name=ansible1.9-$$ --label=ansible1.9 peru/ansible1.9 \
"

sudo docker $DOCKER_PARAMETERS ansible-playbook sites/cluster/site.yml --tags stack
```


## License

BSD


## Author Information

This repo was created in 2016 by <petr.ruzicka@gmail.com>
