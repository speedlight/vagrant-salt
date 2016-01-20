=================
Vagrant with Salt
=================

A vagrant configuration to create 3 VMs based on Debian 8 "Jessie". One as salt master and two as minions.

Requirements
============

Tested on Windows 8/10 and Linux.
Git, Vagrant 1.7+ and Virtualbox 5 was used. Could work with some older versions but due to many fixes in the salt provision module is advisable to run with this versions or newer.

Steps
=====

Just clone the repo and run vagrant:

.. code-block:: bash
    git clone https://github.com/speedlight/vagrant-salt.git
    cd vagrant-salt
    vagrant up

Then enter in the salt master and start working with salt:
.. code-block:: bash
    vagrant ssh master
    sudo salt \* test.ping
