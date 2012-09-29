#!/usr/bin/env ruby

require 'openssl'
require 'base64'
require 'securerandom'
require 'json'

##
## SET THESE VARIABLES to something like...
##
##     @tent_server = "myusername.tent.is"
##     current_auth_details = '{"mac_key_id":"u:...","mac_key":"...","mac_algorithm":"hmac-sha-256"}'
##
@tent_server = ""
current_auth_details = ''


if @tent_server == ""
  abort("Set `@tent_server` at the top of this file")
end
if current_auth_details == ""
  abort("Set `current_auth_details` variable at the top of this file (visit https://YOURUSERNAME.tent.is then View Source to get this value)")
end


tent_config = JSON.parse(current_auth_details)

@mac_key = tent_config["mac_key"]
@mac_key_id = tent_config["mac_key_id"]
@mac_algorithm = tent_config["mac_algorithm"]

@time = Time.now.to_i

def sign_request(env)
  @nonce = SecureRandom.hex(3)
  request_string = build_request_string(env)
  # puts "request_string: #{request_string}"
  encode_me = OpenSSL::HMAC.digest(openssl_digest.new, @mac_key, request_string)
  # puts "encode_me: #{encode_me}"
  @signature = Base64.encode64(encode_me).sub("\n", '')
  env[:request_headers]['Authorization'] = build_auth_header()
end

def openssl_digest
  @openssl_digest ||= OpenSSL::Digest.const_get(@mac_algorithm.to_s.gsub(/hmac|-/, '').upcase)
end

def build_request_string(env)
  [@time.to_s, @nonce, env[:method].to_s.upcase, env[:url].request_uri, @tent_server, env[:url].port, nil, nil].join("\n")
end

def build_auth_header()
  %Q(MAC id="#{@mac_key_id}", ts="#{@time}", nonce="#{@nonce}", mac="#{@signature}")
end

class URL
  def request_uri
    "/tent/posts"
  end

  def port
    "443"
  end
end

def get_body
  js = '{"type": "https://tent.io/types/post/status/v0.1.0","published_at": %d,"permissions": {"public": true},"licenses": ["http://creativecommons.org/licenses/by/3.0/"],"content": {"text": "%s"}}' % [@time.to_i, ARGV.join(" ")]
  js.to_json
end


env = {
  request_headers: {},
  body: get_body(),
  method: "post",
  url: URL.new,
}

sign_request(env)

resp = system("curl -d #{env[:body]} -X POST -H \"Content-Type: application/vnd.tent.v0+json\" -H \"Accept: application/vnd.tent.v0+json\" -H 'Authorization: #{build_auth_header()}' https://#{@tent_server}#{env[:url].request_uri}")

if !resp
  abort("Make sure you have curl installed and try again")
end

puts "\n\nIf you see JSON, it worked! Otherwise... something went wrong :-("
