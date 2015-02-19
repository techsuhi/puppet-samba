class samba::service {

  if $::samba::cifs {
    service { $::samba::cifs_service:
      ensure     => 'running',
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => Class['::samba::adjoin']
    }
  }

  if $::samba::winbind {
    service { $::samba::winbind_service:
      ensure     => 'running',
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => Class['::samba::adjoin']
    }
  }

}
