class Devise::Oauth2Providable::AuthorizationCode 
  include Mongoid::Document
  include Mongoid::Timestamps
  include Devise::Oauth2Providable::ExpirableToken
  store_in :authorization_codes



  
  expires_according_to :authorization_code_expires_in
end
