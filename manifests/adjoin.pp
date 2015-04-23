class samba::adjoin {

  exec { "net_ads_join":
    environment => "ADS_CREDS=${::samba::adjoin_user}%${::samba::adjoin_pass}",
    command     => "/usr/bin/net ads join createcomputer=\"${::samba::adjoin_ou}\" -U \$ADS_CREDS",
    unless      => '/usr/bin/net ads testjoin',
    require     => Class['samba::config'],
  }

}
