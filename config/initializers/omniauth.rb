Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '412182575633605', '05a765cea352c7bd2df2bdcb22cb8f73',
           :scope => 'email', :display => 'popup'
end