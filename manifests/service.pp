class samba::service {

  service { 'samba':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['samba'],
  }

}
