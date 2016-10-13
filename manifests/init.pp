class samba (
  # module parameters
  $package_ensure = $samba::params::package_ensure,

  # common parameters
  $common_packages = $samba::params::common_packages,
  $workgroup       = $samba::params::workgroup,
  $serverstring    = $samba::params::serverstring,
  $security        = $samba::params::security,
  $netbiosname     = $samba::params::netbiosname,

  # active directory parameters
  $ad_mgmt         = $samba::params::ad_mgmt,
  $ad_user         = $samba::params::ad_user,
  $ad_pass         = $samba::params::ad_pass,
  $ad_ou           = $samba::params::ad_ou,
  $kerberos_method = $samba::params::kerberos_method,
  $realm           = $samba::params::realm,

  # cifs parameters
  $cifs          = $samba::params::cifs,
  $cifs_packages = $samba::params::cifs_packages,
  $cifs_service  = $samba::params::cifs_service,

  # ldap parameters
  $ldap                = $samba::params::ldap,
  $backend             = $samba::params::backend,
  $ldap_ssl            = $samba::params::ldap_ssl,
  $ldap_admindn        = $samba::params::ldap_admindn,
  $ldap_adminpw        = $samba::params::ldap_adminpw,
  $ldap_suffix         = $samba::params::ldap_suffix,
  $ldap_user_suffix    = $samba::params::ldap_user_suffix,
  $ldap_group_suffix   = $samba::params::ldap_group_suffix,
  $ldap_machine_suffix = $samba::params::ldap_machine_suffix,
  $sid                 = sid,

  # winbind parameters
  $winbind                    = $samba::params::winbind,
  $winbind_packages           = $samba::params::winbind_packages,
  $winbind_service            = $samba::params::winbind_service,
  $winbind_enum_groups        = $samba::params::winbind_enum_groups,
  $winbind_enum_users         = $samba::params::winbind_enum_users,
  $winbind_refresh_tickets    = $samba::params::winbind_refresh_tickets,
  $winbind_use_default_domain = $samba::params::winbind_use_default_domain,
  $winbind_cache_time         = $samba::params::winbind_cache_time,
  $winbind_offline_logon      = $samba::params::winbind_offline_logon,
  $winbind_nested_groups      = $samba::params::winbind_nested_groups,
  $winbind_expand_groups      = $samba::params::winbind_expand_groups,
  $winbind_nss_info           = $samba::params::winbind_nss_info,
  $template_shell             = $samba::params::template_shell,
  $template_homedir           = $samba::params::template_homedir,
  $idmap_backend              = $samba::params::idmap_backend,
  $idmap_uid                  = $samba::params::idmap_uid,
  $idmap_gid                  = $samba::params::idmap_gid,
  $idmap_cache_time           = $samba::params::idmap_cache_time,
) inherits samba::params {

  class { 'samba::install': ; } ->
  class { 'samba::config':  ; } ~>
  class { 'samba::service': ; }

  contain 'samba::ad'

}
