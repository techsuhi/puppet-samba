class samba::params {

  $workgroup = 'SAMBA'
  $serverstring = 'Server %h'
  $security = 'user'
  $backend = 'tdbsam'
  $ldap_ssl = 'off'
  $ldap_admindn = ''
  $ldap_adminpw = ''
  $ldap_suffix = ''
  $ldap_user_suffix = 'ou=user'
  $ldap_group_suffix = 'ou=group'
  $ldap_machine_suffix = 'ou=machine'
  $sid = ''

}
