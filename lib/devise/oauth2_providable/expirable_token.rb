require 'active_support/concern'
require 'mongoid'

module Devise
  module Oauth2Providable
    module ExpirableToken
      extend ActiveSupport::Concern

      module ClassMethods
        def expires_according_to(config_name)
          cattr_accessor :default_lifetime
          self.default_lifetime = Rails.application.config.devise_oauth2_providable[config_name]
          
          field :token, :type=>String
          field :expires_at, :type=> Time
          belongs_to :user
          belongs_to :client, :class_name=> "Devise::Oauth2Providable::Client"

          after_initialize :init_token, :on => :create, :unless => :token?
          after_initialize :init_expires_at, :on => :create, :unless => :expires_at?
          validates :expires_at, :presence => true
          validates :client, :presence => true
          validates :token, :presence => true, :uniqueness => true
          index "expires_at" => 1
          index "token" => 1
          index "user.id" => 1
          index "client.id" => 1
          scope :not_expired,where(:expires_at.gt => Time.now.utc)
          

          include LocalInstanceMethods
          
          def self.find_by_token(tok)
            where(token: tok).where(:expires_at.gt => Time.now.utc).first
         end
           
        end
      end

      module LocalInstanceMethods
        # number of seconds until the token expires
        def expires_in
          (expires_at - Time.now.utc).to_i
        end

        # forcefully expire the token
        def expired!
          self.expires_at = Time.now.utc
          self.save!
        end

        private

        def init_token
          self.token = Devise::Oauth2Providable.random_id
        end
        def init_expires_at
          self.expires_at = self.default_lifetime.from_now.to_time.utc
        end
      end
    end
  end
end
