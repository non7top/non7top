

__check_file_exist() {
    # Checks if file exists and is readable
    # $1 = file full path
    F=$1
    if [ ! -r "${F}" ]; then
        echo "File ${F} doesn't exists or not readable"
        return 1
    fi
    return 0
}



_get_snapshot_root() {
    # $1 = config file
    C=$1
    __check_file_exist "${C}" || return 1
    SR=$( awk '/^snapshot_root/{print $2}' "${C}" )
    if [ -z "${SR}" ]; then
        echo "No snapshot_root specified in ${C}"
        return 2
    fi
    echo ${SR}
    return 0
}


# Tests
#get_snapshot_root /etc/fstab

