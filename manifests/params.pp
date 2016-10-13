class samba::params {

  # module parameters
  $package_ensure = 'present'

  # common parameters
  $workgroup    = 'SAMBA'
  $serverstring = 'Server %h'
  $security     = 'user'
  $netbiosname  = $::hostname

  # cifs-server parameters
  $cifs = true

  # active directory parameters
  $ad_mgmt         = "disabled"
  $ad_user         = "changeme"
  $ad_pass         = "changeme"
  $ad_ou           = 'Computers'
  $kerberos_method = 'system keytab'
  $realm           = $domain

  # ldap parameters
  $ldap = false
  $ldap_ssl = 'off'
  $ldap_admindn = ''
  $ldap_adminpw = ''
  $ldap_suffix = ''
  $ldap_user_suffix = 'ou=user'
  $ldap_group_suffix = 'ou=group'
  $ldap_machine_suffix = 'ou=machine'
  $sid = ''
  $backend = 'tdbsam'

  # winbind parameters
  $winbind  = false
  $winbind_enum_groups = 'yes'
  $winbind_enum_users =  'yes'
  $winbind_refresh_tickets = 'true'
  $winbind_use_default_domain = 'yes'
  $winbind_cache_time = '300'
  $winbind_offline_logon = 'false'
  $winbind_nested_groups = 'yes'
  $winbind_expand_groups = '3'
  $winbind_nss_info = 'rfc2307'
  $template_shell = '/bin/bash'
  $template_homedir = '/home/%U'
  $idmap_backend = 'ad'
  $idmap_uid = '10000-20000'
  $idmap_gid = '10000-20000'
  $idmap_cache_time = '604800'

  # distribution specific parameters
  case $operatingsystem {
    'RedHat': {
      if $samba::ldap { fail("LDAP isn't supported on ${operatingsystem} yet") }
      if $samba::cifs { fail("CIFS isn't supported on ${operatingsystem} yet") }

      $common_packages = ['samba-common']
      $cifs_packages = ['']
      $cifs_service  = 'samba'
      $winbind_packages = ['samba-winbind', 'samba-winbind-modules']
      $winbind_service  = 'winbind'
    }
    'Debian': {
      if $samba::winbind { fail("Winbind isn't supported on ${operatingsystem} yet") }

      $common_packages = ['samba-common']
      $cifs_packages = ['samba', 'samba-common-bin']
      $cifs_service  = 'samba'
      $winbind_packages = ['']
      $winbind_service  = 'winbind'
    }
  }
  
}
