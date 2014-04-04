class Devise::Oauth2Providable::RefreshToken 
  include Mongoid::Document
  include Mongoid::Timestamps
  include Devise::Oauth2Providable::ExpirableToken
  store_in :refresh_tokens

  

  
  expires_according_to :refresh_token_expires_in

  has_many :access_tokens, :class_name=> "Devise::Oauth2Providable::AccessToken", dependent: :destroy
end
