# Clint: The first command line client for [Tent.is](https://tent.is)

![clint](http://i.imgflip.com/3rfu.jpg)

## Install

    mkdir ~/bin
    curl --output ~/bin/clint --remote-name https://raw.github.com/elimisteve/clint/master/clint.rb
    chmod u+x ~/bin/clint


## Simple Config

Open `~/bin/clint` in your favorite text editor, then set the two
clearly marked variables at the top of the file: `@tent_server` and
`current_auth_details`.

The value for `@tent_server` should be of the form
"myusername.tent.is".

The correct value for `current_auth_details` is some JSON embedded in
the page source of your Tent.is page -- e.g.,
<https://elimisteve.tent.is> for me since my username `elimisteve`.
To view source, right-click anywhere on the page then select "View
Page Source" or similar and look for the line that begins with
`current_auth_details`.  Copy and paste the string within that lines
call to `JSON.parse`.

The resulting values should look something like this:

    @tent_server = 'elimisteve.tent.is'
    current_auth_details = '{"mac_key_id":"u:...","mac_key":"...","mac_algorithm":"hmac-sha-256"}'


## Usage

Make sure `~/bin/` is in your `$PATH`, then run

    clint "My first post to tent.is from the command line"

Have fun :-).  Thanks to the Tent.io team for trying to decentralize,
and thereby revolutionize, social media as we know it.


## How awesome is `clint`?

![chair](http://i.imgflip.com/3rg4.jpg)


## Where did the name "clint" come from?

"Clint" is the wannabe reverse quasi-portmanteau of "Tent" and
"client"


## Install Requirements

You must have `curl` installed.  I've tested clint on Linux using Ruby
1.9.2.  Should work on OS X as well.  Not sure about Windows...


## Attribution

`clint.rb` is largely a modified version of a specific part of the
[tent-client-ruby source](https://github.com/tent/tent-client-ruby/blob/master/lib/tent-client/middleware/mac_auth.rb),
which generates much of the text needed by `curl` to post your status
updates to Tent.is.
