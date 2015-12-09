

boot.kernelPackages = pkgs.linuxPackages_custom {
  version = "3.18.1-custom";
  src = pkgs.fetchurl {
    url = "mirror://kernel/linux/kernel/v3.x/linux-3.18.1.tar.xz";
    sha256 = "13m0s2m0zg304w86yvcmxgbjl41c4kc420044avi8rnr1xwcscsq";
  };
  configfile = /etc/nixos/customKernel.config;
};
