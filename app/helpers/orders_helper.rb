module OrdersHelper

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
    #return link_to_if(link_class == 'finished', title(step), wizard_path(step))
    return link_to_if(true, title(step), wizard_path(step))
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
