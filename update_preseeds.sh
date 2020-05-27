#!/usr/bin/env bash

if [ $# -ne 1 ]; then
    echo "usage: $0 <preseed_file_path>"
    exit 1
fi

preseed=$1

echo -n "[+] removing your local .config file. Agreed ? (y/n) "
read resp;
if [ "$resp" != "y" ]; then
    echo "[-] User abort"
    exit 2;
fi

rm ../.config
rm -rf ../include

echo "[+] This is the preseed file updater script"

if [ ! -f $preseed ]; then
    echo "[-] presseed $preseed is not a regular file ! leaving...";
    exit 1;
fi

preseed_target=${preseed#*/}

echo "[+] Updating pressed file against the currently deployed working directory"
echo "[+] preseed: $preseed"

echo -n "[?] Are you okay to update the preseed ? (y/n) "
read resp;

if [ "$resp" != "y" ]; then
    echo "[-] User abort"
    exit 2;
fi

echo "[+] starting preseed update"
echo "[i] for new options that have default values, default values will be used."
echo "[i] for new options without such values, you will be questioned."
echo -n "[?] Ready ? (y/n) "

read resp;

if [ "$resp" != "y" ]; then
    echo "[-] User abort"
    exit 2;
fi

make -C .. $preseed_target
make -C .. prepare

echo -n "[+] Do you wish to examine the differences between preceeds ? (y/n) "
read resp;

if [ "$resp" = "y" ]; then

    tmp_oldpreseed=`mktemp`
    tmp_newpreseed=`mktemp`

    cat ../.config |sort > $tmp_newpreseed
    cat $preseed|sort > $tmp_oldpreseed

    diff -u $tmp_oldpreseed $tmp_newpreseed

    echo -n "[+] Are you okay with this differences ? (y/n) "
    read resp;

    if [ "$resp" != "y" ]; then
        echo "[-] User abort"
        exit 2;
    fi

else
    echo "[+] Saving preseed without user check [DANGER ZONE]"
fi

echo "[+] starting preseed file update"

cp $tmp_newpreseed $preseed

echo "[+] preseed update done."

exit 0;
