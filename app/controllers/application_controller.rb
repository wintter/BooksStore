class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include OrdersHelper
  include CartItemsHelper

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :name
    end

    def initialize_cart
      @cart = Cart.where(user: current_user).first_or_create
    end

end
