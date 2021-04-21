#!/usr/bin/sh

SERVER="http://localhost:6680/mopidy/rpc"

function send() {
    curl -s -d "$1" -H "Content-Type: application/json" $SERVER
}

function playpause() {
    if [ "$(send '{"jsonrpc": "2.0", "id": 1, "method": "core.playback.get_state"}' | jq .result)" == '"paused"' ]
       then send '{"jsonrpc": "2.0", "id": 1, "method": "core.playback.play"}'
    else send '{"jsonrpc": "2.0", "id": 1, "method": "core.playback.pause"}'
    fi
}

function next() {
    send '{"jsonrpc": "2.0", "id": 1, "method": "core.playback.next"}'
}

function prev() {
    send '{"jsonrpc": "2.0", "id": 1, "method": "core.playback.previous"}'
}


case $1 in
    playpause)
        playpause
        ;;
    next)
        next
        ;;
    prev)
        prev
        ;;
    *)
        echo "Function $1 does not exist.  Usage is one of playpause, next and prev"
esac
