module DeviseHelper
  def devise_error_messages!
    return render_flash_alert! if flash[:alert].present?
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    html = <<-HTML
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
      #{messages}
    </div>
    HTML

    html.html_safe
  end

  def render_flash_alert!
    return '' if flash[:alert].nil?

    html = <<-HTML
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
      #{flash[:alert]}
    </div>
    HTML

    html.html_safe
  end
end