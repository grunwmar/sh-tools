#!/usr/bin/zsh


function sshfs_mount(){
   # arguments: user, address, dir to be mounted, mounted dir
   
   if ! [[ -d $4 ]]; then
	   mkdir -p $4
   fi

   sshfs ${1}@${2}:${3} ${4}
   
   if [[ $? ]]; then
	
	   if [[ $SSHFS_MNT_LINK = false ]]; then
	      exit
	   fi

   	      name=$(basename $4)
	   
	   if [[ -z $SSHFS_MNT_LINK ]]; then
	      SSHFS_MNT_LINK="$HOME/$name"
   	   fi
		echo "$4 --> $SSHFS_MNT_LINK"
	      ln -s $4 $SSHFS_MNT_LINK
   fi
}


function sshfs_umount() {
   # fusermount -u /... TODO
}


case $1 in
	"-m"|"--mount")
		echo $2 $3 $4 $5 $6
	;;
	
	"-u"|"--unmount")
		echo $@
	;;
	
	*)
		echo ""
		echo "    usage: $0 <option> <user> <address> <mounted_dir> <mount_point>"
		echo ""
		echo ""
		echo "    <option> values:"
		echo ""
		echo "        -m / --mount       mount remote directory"
		echo "        -u / --unmount     unmount remote directory"
		echo ""
	;;
esac
