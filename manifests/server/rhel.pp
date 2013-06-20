/*

== Class: openvz::server::rhel

Is included when we include `openvz::server`.

It will disable SELinux (ovz kernel doesn't support it), activate ovz repositories
and install kernel and tools.

*/
class openvz::server::rhel {

  augeas {"disable selinux":
    context => "/files/etc/sysconfig/selinux",
    changes => "set SELINUX disabled",
  }

  exec {"get openvz repo":
    command => "/usr/bin/curl -o /etc/yum.repos.d/openvz.repo http://ftp.openvz.org/openvz.repo",
    creates => "/etc/yum.repos.d/openvz.repo",
  }

  exec {"get openvz key":
    command => "/bin/rpm --import http://ftp.openvz.org/RPM-GPG-Key-OpenVZ",
    unless => "/bin/rpm -qi gpg-pubkey-a7a1d4b6-43281558",
  }

  augeas {"enable needed repo":
    context => "/files/etc/yum.repos.d/openvz.repo/openvz-kernel-rhel$::lsbmajdistrelease/",
    changes => "set enabled 1",
    require => Exec["get openvz repo"],
  }

  augeas {"disable unneeded repos":
    context => $openvz::params::others,
    changes => "set enabled 0",
    require => Exec["get openvz repo"],
  }


  package {["vconfig.x86_64", "bridge-utils.x86_64"]:
    ensure => present,
  }

  package{ $openvz::params::package:
    ensure  => present,
    require => [Augeas["enable needed repo"], Augeas["disable unneeded repos"], Exec["get openvz key"]],
  }
}
