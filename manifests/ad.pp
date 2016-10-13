class samba::ad {

  case $samba::ad_mgmt {
    'join': {
      # join domain
      exec { "net_ads_join":
        environment => "ADS_CREDS=${::samba::adjoin_user}%${::samba::adjoin_pass}",
        command     => "/usr/bin/net ads join createcomputer=\"${::samba::adjoin_ou}\" -U \$ADS_CREDS",
        unless      => '/usr/bin/net ads testjoin',
        require     => Class['samba::config'],
      }
    }

    'leave': {
      # leave domain
      exec { "net_ads_leave":
        command => '/usr/bin/net ads leave',
        onlyif  => '/usr/bin/net ads testjoin',
        require => Class['samba::config'],
        before  => File['/etc/krb5.keytab'],
      }

      # remove old kerberos secrets
      file { '/etc/krb5.keytab':
        ensure => 'absent',
      }
    }
    
    'disabled': {}
  }

}
