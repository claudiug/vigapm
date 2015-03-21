module UsersHelper
  def ranking_badge(user)
    return content_tag(:span, class: "badge") unless user

    span_class = "badge #{user.username.parameterize}-rank"
    span_class << 'alert-danger' if user.ranking < 0

    content_tag(:span, user.ranking, class: span_class)
  end
end
