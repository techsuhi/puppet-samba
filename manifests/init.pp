class samba (
  $workgroup = $samba::params::workgroup,
  $serverstring = $samba::params::serverstring,
  $security = $samba::params::security,
  $backend = $samba::params::backend,
  $ldap_ssl = $samba::params::ldap_ssl,
  $ldap_admindn = $samba::params::ldap_admindn,
  $ldap_adminpw = $samba::params::ldap_adminpw,
  $ldap_suffix = $samba::params::ldap_suffix,
  $ldap_user_suffix = $samba::params::ldap_user_suffix,
  $ldap_group_suffix = $samba::params::ldap_group_suffix,
  $ldap_machine_suffix = $samba::params::ldap_machine_suffix,
  $sid = sid,
) inherits samba::params {

  class {
    'samba::install': ;
    'samba::config':  ;
    'samba::service':  ;
  }


}
