require 'devise/models'

module Devise
  module Models
    module Oauth2Providable
      extend ActiveSupport::Concern
      included do
        has_many :access_tokens, :class_name => 'Devise::Oauth2Providable::AccessToken'
        has_many :authorization_codes, :class_name => 'Devise::Oauth2Providable::AuthorizationCode'
        has_many :refresh_tokens, :class_name => 'Devise::Oauth2Providable::RefreshToken'
      end
    end
  end
end
