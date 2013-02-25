require 'cwa_config'

CwaConfig.config do |c|
  c.msg_url     = 'https://msg.example.com'
  c.msg_user    = 'my_message_user'
  c.msg_pass    = 'my_message_password'
  c.msg_aes_key = 'sharedSecretForPasswordDecryption'
  c.ipa_url     = 'https://ipa.example.com'
  c.ipa_user    = 'freeipa_service_account'
  c.ipa_pass    = 'freeipa_service_account_passwd'
end
