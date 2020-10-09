
FLAGS="$1"
PKG="$2"

#source_size_in_kb=$(emerge -pv "$PKG" | grep 'Size of downloads' | sed 's/^.*[^:]*:[[:space:]]*\([0-9]*\)[[:space:]].*/\1/')
#
#free_ram=$(free | awk '{print $4}' | sed -n 2p)
#tmpfs_percent=0/100
#for_tmpfs=$(($free_ram*$tmpfs_percent))
#
## If doubled source size is greater then size of tmpfs, then we remove tmpfs from fstab and umount it
#
#[ "$((source_size_in_kb*3))" -gt "$for_tmpfs" ] && [ -n "$(grep '/var/tmp/portage' /etc/fstab )" ] || sed -i '/\/var\/tmp\/portage/d' /etc/fstab && umount /var/tmp/portage
#
## If doubled source size is less then size of tmpfs and tmpfs was not previously mounted, then we mount tmpfs
#
#[ "$((source_size_in_kb*3))" -lt "$for_tmpfs" ] && [ -z "$(grep '/var/tmp/portage' /etc/fstab )" ] && printf "tmpfs\t/var/tmp/portage\ttmpfs\tsize=${for_tmpfs}K,uid=portage,gid=portage,mode=775,noatime\t0 0" >> /etc/fstab && mount /var/tmp/portage
#

# Actual installation

emerge $FLAGS "$PKG"
