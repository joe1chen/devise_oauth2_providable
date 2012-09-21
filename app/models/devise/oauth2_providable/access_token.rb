class Devise::Oauth2Providable::AccessToken 
  include Mongoid::Document
  include Mongoid::Timestamps
  include Devise::Oauth2Providable::ExpirableToken
  store_in collection: "access_tokens"
 
  belongs_to :refresh_token, :class_name=> "Devise::Oauth2Providable::RefreshToken" 

  
  expires_according_to :access_token_expires_in

  before_validation :restrict_expires_at, :on => :create, :if => :refresh_token


  
  def token_response
    response = {
      :access_token => token,
      :token_type => 'bearer',
      :expires_in => expires_in
    }
    response[:refresh_token] = refresh_token.token if refresh_token
    response
  end


  private

  def restrict_expires_at
    self.expires_at = [self.expires_at, refresh_token.expires_at].compact.min
  end
end
