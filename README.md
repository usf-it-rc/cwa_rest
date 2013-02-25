= cwa_rest

A very simple REST client used by the CWA (Cluster Web Access) interface

== Another REST client?

Yep.  All I needed was the ability to GET, POST, DELETE JSON objects and I wanted to
dry up my code.  Hence

CwaRest.client({
  :verb => :POST,
  :url  => "https://host.example.com/blah",
  :user => "my_user",
  :password => "my_password",
  :json => {
    'param1' => 'value',
    'param2' => 'value', 
    'param3' => {
      'subparam1' => 'value'
    }
  }
})

Yes.  I was tired of converting Hash => JSON and vice-versa.  This little helper methods
helped to clean up my code a bit.  Nothing fancy. 

There are a couple of other helper methods for encrypting and decrypting AES since this
code is primary used for a password-syncing back-end tool.  I doubt anyone else will
find this code useful except, perhaps, as an example.
