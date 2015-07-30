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

  def tutorial_progress_bar
    wizard_steps.collect do |every_step|
      class_str = 'unfinished'
      class_str = 'current' if every_step == step
      class_str = 'finished' if past_step?(every_step)
      concat(
          content_tag(:span, class: class_str) do
            link(class_str, every_step)
          end
      )
    end
  end

  def link(link_class, step)
    return link_to_if(link_class == 'finished', title(step), wizard_path(step))
    step
  end

  def title(step)
    case step
      when :order_address
        'ADDRESS'
      when :order_delivery
        'DELIVERY'
      when :order_payment
        'PAYMENT'
      else
        'CONFIRM'
    end
  end

end
