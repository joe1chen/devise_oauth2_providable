class Devise::Oauth2Providable::Client 
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: "clients"
  
  field  :name, :type => String
  field  :redirect_uri, :type => String
  field  :website, :type => String
  field  :cidentifier, :type => String
  field  :secret, :type => String
  
  
  has_many :access_tokens, :class_name=> "Devise::Oauth2Providable::AccessToken", dependent: :destroy
  has_many :refresh_tokens, :class_name=>  "Devise::Oauth2Providable::RefreshToken", dependent: :destroy
  has_many :authorization_codes, :class_name=> "Devise::Oauth2Providable::AuthorizationCode", dependent: :destroy

  before_validation :init_identifier, :on => :create, :unless => :cidentifier?
  before_validation :init_secret, :on => :create, :unless => :secret?
  validates :website, :secret, :presence => true
  validates :name, :presence => true, :uniqueness => true
  validates :cidentifier, :presence => true, :uniqueness => true
  index "cidentifier" => 1
  attr_accessible :name, :website, :redirect_uri

  def self.find_by_client_identifier(cid)
    where(cidentifier: cid).first
  end
  
  private

  def init_identifier
    self.cidentifier = Devise::Oauth2Providable.random_id
  end
  def init_secret
    self.secret = Devise::Oauth2Providable.random_id
  end
end
