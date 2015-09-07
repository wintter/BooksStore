module UserCart

  module InitCart
    extend ActiveSupport::Concern

    included { before_action :initialize_cart }

    def initialize_cart
      @cart = current_user.cart
    end

  end

  module CalcPrice
    extend ActiveSupport::Concern

    included { after_filter :calculate_price, only: [:add_to_cart, :update, :destroy, :coupon] }

    def calculate_price
      current_user.cart.calculate_total_price
    end

  end



end
