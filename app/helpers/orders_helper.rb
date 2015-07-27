module OrdersHelper

  def get_session_value(entity, type)
    if session[entity]
      session[entity][type]
    else
      nil
    end
  end

  def check_valid_request(entity, params)
    @info = entity.new(params)
    session['order_' + entity.to_s.downcase!] = @info.attributes
    if @info.valid?
      true
    else
      @address = @info if entity.eql? Address
      @credit_card = @info if entity.eql? CreditCard
      false
    end
  end

  def get_checked_value(entity, type)
    true if type.eql?('5') || entity.eql?(type)
  end

  def remove_key(hash)
    hash.except!('id', 'created_at', 'updated_at')
  end

end
