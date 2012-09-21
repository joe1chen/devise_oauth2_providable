Factory.define :client, :class => Devise::Oauth2Providable::Client do |f|
  f.name 'test'
  f.website 'http://www.foo.com'
  f.redirect_uri 'http://www.foo.com/redirect'
end
