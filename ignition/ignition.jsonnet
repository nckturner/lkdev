{
  ignition: { version: "2.0.0" },
  systemd: {
    units: [{
      name: "example.service",
      enable: true,
      contents: importstr "example.service",
    }],
  },
  passwd: {
    users: [{
      name: "mikedanese",
      passwordHash: "",
    }],
  },
  storage: {
    files: [{
      filesystem: "root",
      path: "/etc/cloud/cloud-init.disabled",
      contents: { source: "data:," },
    }],
  },
}
