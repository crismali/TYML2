$ ->
  $('#auto_complete').typeahead
    source: autocomplete_items

  modalShareHideShow = ->
    overlay = $('.modal-overlay')
    speed = 300
    if overlay.is ':hidden'
      overlay.fadeIn speed
      $('body').css
        overflow: 'hidden'
    else
      overlay.fadeOut speed
      $('body').css
        overflow: 'visible'

  $('[data-behavior="share-tyml"]').on "click", (e) ->
    e.preventDefault()
    modalShareHideShow()

  $('.modal-overlay').on "click", (e) ->
    e.preventDefault()
    modalShareHideShow()

  # prevent modal from closing if clicking inside form
  $('.modal-overlay .share-container').on "click", (e) ->
    e.stopPropagation()

  $(window).on "keyup", (e) ->
    if e.which is 27 and $('.modal-overlay').is(':visible')
      modalShareHideShow()

  $('p.tyml-url').embedly
    maxWidth: 450
    wmode: 'transparent'
    method: 'replace'
    key: ':08733383f86a47f1a66ea5dfa481ca02'
    className: 'embedly group'
    query:
      chars: 180


