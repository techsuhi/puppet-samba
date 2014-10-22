class samba::install {

  package { ['samba', 'samba-common-bin']:
    ensure => 'present',
  }

}
