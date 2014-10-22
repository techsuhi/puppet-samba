define samba::share (
  $comment,
  $browseable    = 'no',
  $path,
  $readonly      = 'yes',
  $guestok       = 'no',
  $createmask    = '0700',
  $directorymask = '0700',
  $validusers    = '',
) {

  $t_validusers = $validusers ? { '' => '', default => "set \"\$target/valid users\" \"${validusers}\"" }

  augeas { "smb.conf-${name}":
    context => '/files/etc/samba/smb.conf',
    changes => [
      "defnode target target[. = \"${name}\"]/ \"${name}\"",
      "set \"\$target/comment\" \"${comment}\"",
      "set \"\$target/browseable\" ${browseable}",
      "set \"\$target/path\" \"${path}\"",
      "set \"\$target/read only\" ${readonly}",
      "set \"\$target/guest ok\" ${guestok}",
      "set \"\$target/create mask\" ${createmask}",
      "set \"\$target/directory mask\" ${directorymask}",
      $t_validusers,
    ],  
    onlyif => "match *[target = '${name}'][comment = '${comment}'][browseable = '${browseable}'][path = '${path}'][read only = '${readonly}'][guest = '${guest}'][create mask = '${createmask}'][directory mask = '${directorymask}'][valid users = '${validusers}'] size == 0",
    require => Package['samba'],
    notify  => Service['samba'],
  }



}
