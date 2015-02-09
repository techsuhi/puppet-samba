class samba::service {

  if $::samba::cifs {
    service { $::samba::cifs_service:
      ensure     => 'running',
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => Class['::samba::adjoin']
#      require    => Package[$::samba::cifs_packages],
#      subscribe  => Augeas['smb.conf-common'],
    }
  }

  if $::samba::winbind {
    service { $::samba::winbind_service:
      ensure     => 'running',
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => Class['::samba::adjoin']
#      require    => Package[$::samba::winbind_packages],
#      subscribe  => Augeas['smb.conf-common'],
    }
  }

}
