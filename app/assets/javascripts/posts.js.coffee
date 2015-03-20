$ ->
  $('.container').on 'click', '#new-post-comment', (e)->
    e.preventDefault()
    comment_field = $('#_posts_comment_field')
    $('body').animate
      scrollTop: comment_field.offset().top,
      500
    comment_field.focus()
