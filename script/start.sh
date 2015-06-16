#!/usr/bin/env bash
set -o errexit
#set -x

__DIR__="$(cd "$(dirname "${0}")"; echo $(pwd))"
__BASE__="$(basename "${0}")"
__FILE__="${__DIR__}/${__BASE__}"

# Give permissions to read and write in workdir for users root and www-data
setfacl -R -m u:www-data:rwx -m u:root:rwx /var/www
setfacl -dR -m u:www-data:rwx -m u:root:rwx /var/www

main () {
  if [ $APACHE_USER_UID != 0 ];then
    usermod -u $APACHE_USER_UID $APACHE_RUN_USER
  fi
  /usr/sbin/apache2 -D FOREGROUND
}

main
