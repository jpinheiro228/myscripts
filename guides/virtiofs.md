# Virtiofs Guide

## HOST

Add a Filesystem device to your VM using the following XML or
by using the wizard.

```xml
<filesystem type="mount" accessmode="mapped">
  <driver type="path" wrpolicy="immediate"/>
  <source dir="<FULL_PATH_TO_FOLDER>"/>
  <target dir="<FRIENDLY_NAME>"/>
  <readonly/>
</filesystem>
```

## GUEST

Create a file to load the necessary kernel modules at boot time:

```bash
echo "9p
9pnet
9pnet_virtio" > /etc/modules.d/9p.conf
```

Mount it manually with:

```bash
mount -t 9p trans=virtio <FRIENDLY_NAME> <MOUNT_PATH>
```

or add the following line to you `/etc/fstab` so it mounts your FS at boot time:

```text
<FRIENDLY_NAME> <MOUNT_PATH> 9p trans=virtio 0 0
```
