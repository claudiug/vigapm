$ ->
  $('.container').on 'click', '#new-post-comment', (e)->
    e.preventDefault()
    comment_field = $('#_posts_comment_field')
    $('body').animate
      scrollTop: comment_field.offset().top,
      500
    comment_field.focus()

  editor = new MediumEditor('.editable', placeholder: 'Write your text')
  $('.editable').mediumInsert
    editor: editor
    addons: images: imagesUploadScript: '/post'
  $('.editable:first').focus()
  $('#_newpost_submit').on 'click', ->
    $('.mediumInsert-buttons').remove()
    $('#post_body').val $('#_newpost_body').html()
    $('#new_post').submit()
    return
