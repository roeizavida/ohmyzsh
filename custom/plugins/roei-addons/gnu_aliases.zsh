# Use GNU tools instead of Mac defaults
# for cmd in $(ls /usr/local/bin/g*)
# do
#     echo "alias $(echo $cmd | \
#     awk -F '/usr/local/bin/' '{ print $2 }' | \
#     gsed -E "0,/g/s///")=$(echo $cmd | \
#     awk -F '/usr/local/bin/' '{ print $2 }')"
# done

alias awk=/usr/local/bin/gawk
alias b2sum=/usr/local/bin/gb2sum
alias base32=/usr/local/bin/gbase32
alias base64=/usr/local/bin/gbase64
alias basename=/usr/local/bin/gbasename
alias basenc=/usr/local/bin/gbasenc
alias cat=/usr/local/bin/gcat
alias chcon=/usr/local/bin/gchcon
alias chgrp=/usr/local/bin/gchgrp
alias chmod=/usr/local/bin/gchmod
alias chown=/usr/local/bin/gchown
alias chroot=/usr/local/bin/gchroot
alias cksum=/usr/local/bin/gcksum
alias cloud=/usr/local/bin/gcloud
alias comm=/usr/local/bin/gcomm
alias cp=/usr/local/bin/gcp
alias csplit=/usr/local/bin/gcsplit
alias cut=/usr/local/bin/gcut
alias date=/usr/local/bin/gdate
alias dbm_dump=/usr/local/bin/gdbm_dump
alias dbm_load=/usr/local/bin/gdbm_load
alias dbmtool=/usr/local/bin/gdbmtool
alias dd=/usr/local/bin/gdd
alias df=/usr/local/bin/gdf
alias dir=/usr/local/bin/gdir
alias dircolors=/usr/local/bin/gdircolors
alias dirname=/usr/local/bin/gdirname
alias du=/usr/local/bin/gdu
alias echo=/usr/local/bin/gecho
alias egrep=/usr/local/bin/gegrep
alias env=/usr/local/bin/genv
alias ettext=/usr/local/bin/gettext
alias ettext.sh=/usr/local/bin/gettext.sh
alias ettextize=/usr/local/bin/gettextize
alias expand=/usr/local/bin/gexpand
alias expr=/usr/local/bin/gexpr
alias factor=/usr/local/bin/gfactor
alias false=/usr/local/bin/gfalse
alias fgrep=/usr/local/bin/gfgrep
alias find=/usr/local/bin/gfind
alias fmt=/usr/local/bin/gfmt
alias fold=/usr/local/bin/gfold
alias grep=/usr/local/bin/ggrep
alias groups=/usr/local/bin/ggroups
alias head=/usr/local/bin/ghead
alias hostid=/usr/local/bin/ghostid
alias id=/usr/local/bin/gid
alias indent=/usr/local/bin/gindent
alias install=/usr/local/bin/ginstall
alias join=/usr/local/bin/gjoin
alias kill=/usr/local/bin/gkill
alias link=/usr/local/bin/glink
alias ln=/usr/local/bin/gln
alias locate=/usr/local/bin/glocate
alias logname=/usr/local/bin/glogname
alias ls=/usr/local/bin/gls
alias md5sum=/usr/local/bin/gmd5sum
alias mkdir=/usr/local/bin/gmkdir
alias mkfifo=/usr/local/bin/gmkfifo
alias mknod=/usr/local/bin/gmknod
alias mktemp=/usr/local/bin/gmktemp
alias mv=/usr/local/bin/gmv
alias nice=/usr/local/bin/gnice
alias nl=/usr/local/bin/gnl
alias nohup=/usr/local/bin/gnohup
alias nproc=/usr/local/bin/gnproc
alias numfmt=/usr/local/bin/gnumfmt
alias nutls-certtool=/usr/local/bin/gnutls-certtool
alias nutls-cli=/usr/local/bin/gnutls-cli
alias nutls-cli-debug=/usr/local/bin/gnutls-cli-debug
alias nutls-serv=/usr/local/bin/gnutls-serv
alias od=/usr/local/bin/god
alias paste=/usr/local/bin/gpaste
alias pathchk=/usr/local/bin/gpathchk
alias pinky=/usr/local/bin/gpinky
alias printenv=/usr/local/bin/gprintenv
alias printf=/usr/local/bin/gprintf
alias ptx=/usr/local/bin/gptx
alias pwd=/usr/local/bin/gpwd
alias readlink=/usr/local/bin/greadlink
alias realpath=/usr/local/bin/grealpath
alias rm=/usr/local/bin/grm
alias rmdir=/usr/local/bin/grmdir
alias runcon=/usr/local/bin/gruncon
alias sed=/usr/local/bin/gsed
alias seq=/usr/local/bin/gseq
alias sha1sum=/usr/local/bin/gsha1sum
alias sha224sum=/usr/local/bin/gsha224sum
alias sha256sum=/usr/local/bin/gsha256sum
alias sha384sum=/usr/local/bin/gsha384sum
alias sha512sum=/usr/local/bin/gsha512sum
alias shred=/usr/local/bin/gshred
alias shuf=/usr/local/bin/gshuf
alias sleep=/usr/local/bin/gsleep
alias sort=/usr/local/bin/gsort
alias split=/usr/local/bin/gsplit
alias stat=/usr/local/bin/gstat
alias stdbuf=/usr/local/bin/gstdbuf
alias stty=/usr/local/bin/gstty
alias sum=/usr/local/bin/gsum
alias sync=/usr/local/bin/gsync
alias tac=/usr/local/bin/gtac
alias tail=/usr/local/bin/gtail
alias tar=/usr/local/bin/gtar
alias tee=/usr/local/bin/gtee
alias test=/usr/local/bin/gtest
alias timeout=/usr/local/bin/gtimeout
alias touch=/usr/local/bin/gtouch
alias tr=/usr/local/bin/gtr
alias true=/usr/local/bin/gtrue
alias truncate=/usr/local/bin/gtruncate
alias tsort=/usr/local/bin/gtsort
alias tty=/usr/local/bin/gtty
alias uname=/usr/local/bin/guname
alias unexpand=/usr/local/bin/gunexpand
alias uniq=/usr/local/bin/guniq
alias unlink=/usr/local/bin/gunlink
alias updatedb=/usr/local/bin/gupdatedb
alias uptime=/usr/local/bin/guptime
alias users=/usr/local/bin/gusers
alias vdir=/usr/local/bin/gvdir
alias wc=/usr/local/bin/gwc
alias which=/usr/local/bin/gwhich
alias who=/usr/local/bin/gwho
alias whoami=/usr/local/bin/gwhoami
alias xargs=/usr/local/bin/gxargs
alias yes=/usr/local/bin/gyes