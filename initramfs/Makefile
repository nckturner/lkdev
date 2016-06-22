
WORKSPACE  ?= ..
BUILD_DIR ?= $(WORKSPACE)/.tmp
ROOT_DIR ?= $(BUILD_DIR)/initramfs

default: $(BUILD_DIR)/initramfs.cpio.gz

folders = bin dev etc lib lib64 mnt/root proc root sbin sys opt
$(folders:%=$(ROOT_DIR)/%):
	mkdir -p $@

$(ROOT_DIR):
	mkdir -p $@
	curl -sSL --fail \
		"https://github.com/docker-library/busybox/raw/729aa3010c3ee9088e74647d9f04a4c338fa86c4/glibc/busybox.tar.xz" \
		| tar xvJ -C $@

IGNITION = $(ROOT_DIR)/bin/ignition
$(IGNITION): $(ROOT_DIR)
	curl -sSL --fail \
		"https://storage.googleapis.com/public-mikedanese-k8s/ignition" \
		-o $@
	chmod +x $@

INIT = $(ROOT_DIR)/init
$(INIT): $(ROOT_DIR) init
	cp init $@

$(BUILD_DIR)/initramfs.cpio.gz: $(IGNITION) $(INIT) $(folders:%=$(ROOT_DIR)/%)
	( cd $(ROOT_DIR); \
	find . -print0 \
		| cpio --null -ov --format=newc \
		| gzip -9 ) \
		> $@
