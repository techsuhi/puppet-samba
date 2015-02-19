class samba::adjoin {

  exec { "net_ads_join":
    environment => "ADS_CREDS=${::samba::join_user}%${::samba::join_pass}",
    command     => "/usr/bin/net ads join createcomputer=\"${::samba::join_ou}\" -U \$ADS_CREDS",
    unless      => "/usr/bin/net ads status -U \$ADS_CREDS",
    require     => Class['samba::config'],
  }

}
