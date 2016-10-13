class samba::config {

# will also clear defined shares
#    'clear-shares':
#      context => '/files/etc/samba/smb.conf',
#      changes => [ 'rm target[. != "global"]' ];

  augeas { 'smb.conf-common':
    context => '/files/etc/samba/smb.conf',
    changes => [
      "set \"target[. = 'global']/workgroup\" '$samba::workgroup'",
      "set \"target[. = 'global']/server string\" '$samba::serverstring'",
      "set \"target[. = 'global']/security\" '$samba::security'",
      "set \"target[. = 'global']/netbios name\" '$samba::netbiosname'",
    ],  
  }

  if $::samba::ad_mgmt != 'disabled' {
    augeas { 'smb.conf-ad':
      context => '/files/etc/samba/smb.conf',
      changes => [
        "set \"target[. = 'global']/kerberos method\" '$samba::kerberos_method'",
        "set \"target[. = 'global']/realm\" '$samba::realm'",
      ],  
    }

  }

  if $::samba::winbind {
    augeas { 'smb.conf-winbind':
      context => '/files/etc/samba/smb.conf',
      changes => [
        "set \"target[. = 'global']/winbind enum groups\" '$samba::winbind_enum_groups'",
        "set \"target[. = 'global']/winbind enum users\" '$samba::winbind_enum_users'",
        "set \"target[. = 'global']/winbind refresh tickets\" '$samba::winbind_refresh_tickets'",
        "set \"target[. = 'global']/kerberos method\" '$samba::kerberos_method'",
        "set \"target[. = 'global']/winbind use default domain\" '$samba::winbind_use_default_domain'",
        "set \"target[. = 'global']/winbind cache time\" '$samba::winbind_cache_time'",
        "set \"target[. = 'global']/winbind offline logon\" '$samba::winbind_offline_logon'",
        "set \"target[. = 'global']/winbind nested groups\" '$samba::winbind_nested_groups'",
        "set \"target[. = 'global']/winbind expand groups\" '$samba::winbind_expand_groups'",
        "set \"target[. = 'global']/winbind nss info\" '$samba::winbind_nss_info'",
        "set \"target[. = 'global']/template shell\" '$samba::template_shell'",
        "set \"target[. = 'global']/template homedir\" '$samba::template_homedir'",
        "set \"target[. = 'global']/idmap backend\" '$samba::idmap_backend'",
        "set \"target[. = 'global']/idmap uid\" '$samba::idmap_uid'",
        "set \"target[. = 'global']/idmap gid\" '$samba::idmap_gid'",
        "set \"target[. = 'global']/idmap cache time\" '$samba::idmap_cache_time'",
        "set \"target[. = 'global']/realm\" '$samba::realm'",
      ],  
    }

  }

  if $::samba::ldap {
    augeas { 'smb.conf-ldap':
      context => '/files/etc/samba/smb.conf',
      changes => [
        "set \"target[. = 'global']/passdb backend\" '$samba::backend'",
        "set \"target[. = 'global']/ldap ssl\" '$samba::ldap_ssl'",
        "set \"target[. = 'global']/ldap admin dn\" '$samba::ldap_admindn'",
        "set \"target[. = 'global']/ldap suffix\" '$samba::ldap_suffix'",
        "set \"target[. = 'global']/ldap user suffix\" '$samba::ldap_user_suffix'",
        "set \"target[. = 'global']/ldap group suffix\" '$samba::ldap_group_suffix'",
        "set \"target[. = 'global']/ldap machine suffix\" '$samba::ldap_machine_suffix'",
      ],  
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
      }
    }
  }

}
