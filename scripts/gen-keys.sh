if ! command -v dropbearkey &> /dev/null
then
    echo "Install dropbear and try again"
    exit
fi

read -p "Are you sure you want to generate new keys for this site? [y/N] " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Generating new keys..."

    rm -rf ./hostkeys
    mkdir -p ./hostkeys

    dropbearkey -t rsa -f ./hostkeys/dropbear_rsa_host_key
    dropbearkey -t dss -f ./hostkeys/dropbear_dss_host_key
    dropbearkey -t ecdsa -f ./hostkeys/dropbear_ecdsa_host_key
    dropbearkey -t ed25519 -f ./hostkeys/dropbear_ed25519_host_key

    echo
    echo "New keys generated!"
fi
