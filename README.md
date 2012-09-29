# Clint: the world's first command line Tent.is client


## Install

    mkdir ~/bin
    curl --output ~/bin/clint --remote-name https://github.com/elimisteve/... TODO
    chmod u+x ~/bin/clint


## Simple Config

Open `~/bin/clint` in your favorite text editor, then set the two
clearly marked variables at the top of the file: `@tent_server` and
`current_auth_details`.  The result should look something like this:

    @tent_server = "myusername.tent.is"
    current_auth_details = '{"mac_key_id":"u:...","mac_key":"...","mac_algorithm":"hmac-sha-256"}'


## Usage

Make sure `~/bin/` is in your `$PATH`, then run

    clint "My first post to tent.is from the command line"

Have fun :-).  Thanks to the Tent.io team for trying to decentralize,
and thereby revolutionize, social media as we know it.