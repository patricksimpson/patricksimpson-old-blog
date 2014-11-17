APP =
  init: ->
    @loadTwitter()
    @loadInstagram()
    @postMetaDate()
    @postLinks()

  loadTwitter: ->
    if $('#latesttweet').length > 0
      $.ajax(
        url: '/__/proxy/api/twitter.json'
        type: 'GET'
        dataType: 'json',
        success: (data) ->
          date = moment(data.date).fromNow()
          $("#latesttweet").html("<span class='tweet'>#{data.text}</span><br><span class='meta meta--date'>#{date}</span>")
      )

  loadInstagram: ->
    if $('#instafeed').length > 0
      $.ajax(
        url: '/__/proxy/api/insta.json'
        type: 'GET'
        dataType: 'json',
        success: (data) ->
          html = ''
          for i in [0..3]
            html += "<img src='#{data[i].image.url}' alt='feed'/>"
          $("#instafeed").html(html)
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
