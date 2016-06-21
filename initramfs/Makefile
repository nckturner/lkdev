
WORKSPACE  ?= ..
BUILD_DIR ?= $(WORKSPACE)/.tmp
ROOT_DIR ?= $(BUILD_DIR)/initramfs

default: $(BUILD_DIR)/initramfs.cpio.gz

folders = bin dev etc lib lib64 mnt/root proc root sbin sys opt
$(folders:%=$(ROOT_DIR)/%):
	mkdir -p $@

BUSYBOX = $(ROOT_DIR)/bin/busybox
$(BUSYBOX): /bin/busybox $(ROOT_DIR)/bin
	cp -a $< $@

busybox_cmds = $(shell /bin/busybox --list)

$(busybox_cmds:%=$(ROOT_DIR)/bin/%): $(BUSYBOX)
	ln -s -f $< $@

IGNITION = $(ROOT_DIR)/ignition
$(IGNITION):
	curl -sSL --fail \
		"https://storage.googleapis.com/public-mikedanese-k8s/ignition" \
		-o $@
	

INIT = $(ROOT_DIR)/init
$(INIT): $(ROOT_DIR)
	cp init $@

all = \
	$(folders:%=$(ROOT_DIR)/%) \
	$(busybox_cmds:%=$(ROOT_DIR)/bin/%) \
	$(IGNITION) \
	$(INIT)

$(BUILD_DIR)/initramfs.cpio.gz: $(all)
	( cd $(ROOT_DIR); \
	find . -print0 \
		| cpio --null -ov --format=newc \
		| gzip -9 ) \
		> $@
