class samba::install {

  package { $::samba::common_packages:
    ensure => $::samba::package_ensure,
  }

  if $::samba::cifs {
    package { $::samba::cifs_packages:
      ensure  => $::samba::package_ensure,
      require => Package[$::samba::common_packages],
    }
  }

  if $::samba::winbind {
    package { $::samba::winbind_packages:
      ensure  => $::samba::package_ensure,
      require => Package[$::samba::common_packages],
    }
  }

}
