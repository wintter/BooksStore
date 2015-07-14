if Rails.env == 'development'
  code = '412182575633605'
  secret_key = '05a765cea352c7bd2df2bdcb22cb8f73'
else
  code = '1619406021650927'
  secret_key = '68ca7c28f6d8b62e59bf994615308f4f'
end
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, code, secret_key,
           :scope => 'email', :display => 'popup'
end