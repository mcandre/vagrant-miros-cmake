# vagrant-miros-cmake: a Vagrant box with MirOS (MirBSD) + cmake

# WARNING

(Currently broken.)

# VAGRANT CLOUD

* https://app.vagrantup.com/mcandre/boxes/vagrant-miros-cmake-i386

# EXAMPLE

```console
$ cd i386/test
$ vagrant up
$ vagrant ssh -c "cd /vagrant && cmake . && cmake --build . --target lint && cmake --build . --config Release && bin/hello"
...
```

# RUNTIME REQUIREMENTS

* [Vagrant](https://www.vagrantup.com)
* The [VirtualBox](https://www.virtualbox.org) hypervisor provider

## Recommended

* [vagrant-rsync-back](https://github.com/smerrill/vagrant-rsync-back) assists in copying artifacts from the guest to the host

# BUILDTIME REQUIREMENTS

* [Vagrant](https://www.vagrantup.com)
* The [VirtualBox](https://www.virtualbox.org) hypervisor provider
* [make](https://www.gnu.org/software/make/)
* [wget](https://www.gnu.org/software/wget/)

# EXPORT

```console
$ sh -c "cd i386 && make vagrant-miros-cmake-i386.box"
```
