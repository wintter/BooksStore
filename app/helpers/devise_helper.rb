module DeviseHelper

  def generate_addresses
    current_user.build_billing_address unless current_user.billing_address
    current_user.build_shipping_address unless current_user.shipping_address
  end

  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
      <div class="panel panel-danger font_opensans" id="error_explanation">
      <div class="panel-heading">
        <h3 class="panel-title">#{sentence}</h3>
      </div>
      <div class="panel-body">
        #{messages}
      </div>
      </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end

end