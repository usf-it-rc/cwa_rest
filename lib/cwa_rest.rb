require 'json'
require 'curb'
require 'openssl'
require 'base64'

module CwaRest
  def client(args)
    if !args.is_a?(Hash)      
      raise ArgumentError "Arguments not a hash"
    end 

    c = Curl::Easy.new do |curl|
      curl.url = args[:url]
      if args.has_key?(:json)
        curl.post_body = args[:json].to_json.to_s
      end
      curl.cacert = 'ca.crt'
      curl.http_auth_types = :basic
      curl.username = args[:user]
      curl.password = args[:password]
      curl.ssl_verify_host = false
      curl.ssl_verify_peer = false
      curl.verbose = false
      curl.headers['referer'] = args[:url]
      curl.headers['Accept'] = 'application/json'
      curl.headers['Content-Type'] = 'application/json'
      curl.headers['Api-Version'] = '2.2'
    end

    begin
      c.http args[:verb]
    rescue Exception => e
      raise e.message
    end

    case c.response_code
    when 401
      raise "Bad credentials"
    when 403
      raise "Forbidden"
    end

    begin
      h = JSON.parse(c.body_str).to_hash
    rescue Exception => e
      raise e.message
    end
    c.close
    return h
  end

  def decrypt(encrypted_data, key, cipher_type)
    raw_data = Base64.decode64(encrypted_data)
    aes = OpenSSL::Cipher::Cipher.new(cipher_type)
    aes.decrypt
    aes.key = key
    aes.update(raw_data) + aes.final  
  end

  def encrypt(data, key, cipher_type)
    aes = OpenSSL::Cipher::Cipher.new(cipher_type)
    aes.encrypt
    aes.key = key
    Base64.encode64(aes.update(data) + aes.final)
  end
end
