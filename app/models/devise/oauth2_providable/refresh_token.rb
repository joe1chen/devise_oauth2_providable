class Devise::Oauth2Providable::RefreshToken 
  include Mongoid::Document
  include Mongoid::Timestamps
  include Devise::Oauth2Providable::ExpirableToken
  store_in :refresh_tokens

  field :token, :type=>String
  field :expires_at, :type=> DateTime
  
  def self.find_by_token(tok)
     self.first(:conditions=>{:token=>tok})
   end
  
  expires_according_to :refresh_token_expires_in

  has_many :access_tokens, :class_name=> "Devise::Oauth2Providable::AccessToken" 
end
