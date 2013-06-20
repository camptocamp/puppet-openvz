class openvz::params {
  case $::operatingsystem {
    "RedHat", "CentOS": {
        case $::lsbmajdistrelease {
            6: {
                $package = ["vzkernel","vzctl","ploop","vzquota"]
                $others = "/files/etc/yum.repos.d/openvz.repo/openvz-kernel-rhel5"
            }
            5: {
                $package = ["ovzkernel","vzctl","vzctl-lib","vzquota"]
                $others = "/files/etc/yum.repos.d/openvz.repo/openvz-kernel-rhel6"
            }
            default: {
                fail("Unsupported release: $::lsbmajdistrelease, look at manifests/params.pp")
            }
        }      
    }
    default: {
      fail("Unsupported platform: $::operatingsystem")
    }
  }
}
