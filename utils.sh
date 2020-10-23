# Some utility functions

function _is_free_port() {
    # Return value is 0 if port is free, 1 otherwise
    ! nc -z localhost $1 &>/dev/null
}

function get_available_carla_port() {
    # Prints a port to stdout where it and the next two ports are free.
    #
    # Carla requires three consecutive free ports for its use.
    # Do note there's a time-of-check to time-of-use race condition when using this function.
    while true; do
        port=$((RANDOM % 40000 + 10000))
        if
            $(_is_free_port $port) &&
                $(_is_free_port $((port + 1))) &&
                $(_is_free_port $((port + 2)))
        then
            echo $port
            break
        fi
    done
}
