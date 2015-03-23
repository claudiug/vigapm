module CommentsHelper
  def comment_opacity(comment)
    1 + (comment.cached_votes_up - comment.cached_votes_down) / 10.0
  end

  def comment_posted_ago(comment)
    label_class = comment.created_at > Time.now - 1.days ? 'warning' : 'default'
    span_class = "label label-#{label_class} glyphicon glyphicon-dashboard pull-right"

    content_tag(:span, raw("&nbsp;#{time_ago_in_words(comment.created_at)}"), class: span_class)
  end
end
