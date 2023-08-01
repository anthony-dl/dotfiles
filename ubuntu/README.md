# Important scripts in Ubuntu

## Get installed packages and software from one machine and install to another:
```bash
apt-mark showmanual > custom_installed_packages.txt
sudo apt-get install $(cat custom_installed_packages.txt)
```

## Get added repo to a file and migrate it to a new computer:
```bash
cat /etc/apt/sources.list > custom_repositories.list
cat /etc/apt/sources.list.d/* >> custom_repositories.list
```

Open a terminal on the new machine and run the following commands to add the repositories:
```bash
sudo cp custom_repositories.list /etc/apt/sources.list
sudo cp custom_repositories.list /etc/apt/sources.list.d/
sudo apt update
```


