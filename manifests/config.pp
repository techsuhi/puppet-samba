class samba::config {

  $workgroup = "UNFORGOTTEN"
  $serverstring = "ASERVERstring"
  $security = "user"
  $backend = 'ldapsam:"ldap://mastermind.unforgotten.de/"'
  $ldap_ssl = 'start tls'
  $ldap_admindn = 'cn=samba service,ou=people,ou=serviceaccounts,dc=unforgotten,dc=de'
  $ldap_adminpw = 'iw%f_cew11!PlvfZm_0=dw'
  $ldap_suffix = 'dc=unforgotten,dc=de'
  $ldap_user_suffix = 'ou=people'
  $ldap_group_suffix = 'ou=group'
  $ldap_machine_suffix = 'ou=machines'
  $sid = 'S-1-5-21-4064104595-196718586-568335960'


  augeas {
# will also clear defined shares
#    'clear-shares':
#      context => '/files/etc/samba/smb.conf',
#      changes => [ 'rm target[. != "global"]' ];

    'smb.conf':
      context => '/files/etc/samba/smb.conf',
      changes => [
        "set \"target[. = 'global']/workgroup\" '$samba::workgroup'",
        "set \"target[. = 'global']/server string\" '$samba::serverstring'",
        "set \"target[. = 'global']/security\" '$samba::security'",
        "set \"target[. = 'global']/passdb backend\" '$samba::backend'",
        "set \"target[. = 'global']/ldap ssl\" '$samba::ldap_ssl'",
        "set \"target[. = 'global']/ldap admin dn\" '$samba::ldap_admindn'",
        "set \"target[. = 'global']/ldap suffix\" '$samba::ldap_suffix'",
        "set \"target[. = 'global']/ldap user suffix\" '$samba::ldap_user_suffix'",
        "set \"target[. = 'global']/ldap group suffix\" '$samba::ldap_group_suffix'",
        "set \"target[. = 'global']/ldap machine suffix\" '$samba::ldap_machine_suffix'",
      ],  
      require => Package['samba'],
      notify  => Service['samba'];
  }

# missing check if password is already set
#   if $ldap_adminpw {
#     exec { 'samba_ldap_passwd':
#       environment => "PASSWORD=$ldap_adminpw",
#       command => "smbpasswd -w \$PASSWORD",
#       require => Augeas['smb.conf'],
#      notify  => Service['samba'],
#     }
#   }

  if $sid {
    exec { 'samba_set_localsid':
      command => "net setlocalsid ${sid}",
      unless  => "net getlocalsid | grep -q ${sid}",
      require => Package['samba'],
      notify  => Service['samba'],
    }
  }

}
