$ ->
  $('.container').on 'click', '#new-post-comment', (e)->
    e.preventDefault()
    comment_field = $('#_posts_comment_field')
    $('body').animate
      scrollTop: comment_field.offset().top,
      500
    comment_field.focus()

  $('.container').on 'click', '.new-comments-reply.replybtn', (e)->
    e.preventDefault()
    $(@).next('.new-comment-reply').show()
    @.remove()

  editor = new MediumEditor('.editable', placeholder: 'Write your text')
  form = $('form#new_post, form.edit_post')
  post_tmp_id = form.data('tmp-id')
  $('.editable').mediumInsert
    editor: editor
    addons:
      images:
        uploadScript: "/posts/#{post_tmp_id}/pictures"
  $('.editable:first').focus()
  $('#_newpost_submit').on 'click', ->
    $('.mediumInsert-buttons').remove()
    $('#post_body').val $('#_newpost_body').html()
    $('#new_post').submit()
    return
