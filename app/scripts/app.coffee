APP =
  init: ->
    @loadTwitter()
    @loadInstagram()
    @postMetaDate()

  loadTwitter: ->
    if ('#latesttweet').length > 1
      $.ajax(
        url: '/__/proxy/twitter.json'
        type: 'GET'
        dataType: 'json',
        success: (data) ->
          console.log data
      )

  loadInstagram: ->
    if ('#instafeed').length > 1
      $.ajax(
        url: '/__/proxy/insta.json'
        type: 'GET'
        dataType: 'json',
        success: (data) ->
          console.log data
      )

  postMetaDate: ->
    $('.list-post--date').each((i)->
      $(@).text(moment($(@).text()).fromNow())
    )
    $('.post--date').each((i)->
      $(@).text(moment($(@).text()).format('MMMM D, YYYY'))
    )
    $('.current-year').each((i)->
      $(@).text(moment().format('YYYY') + '.')
    )

APP.init()
