APP =
  init: ->
    @loadTwitter()
    @loadInstagram()
    @postMetaDate()

  loadTwitter: ->
    if $('#latesttweet').length > 1
      $.ajax(
        url: '/__/proxy/api/twitter.json'
        type: 'GET'
        dataType: 'json',
        success: (data) ->
          console.log data
          date = momemnt(data.date).fromNow()
          $("#latesttweet").html("#{data.text} <br>#{date}")
      )

  loadInstagram: ->
    if $('#instafeed').length > 1
      $.ajax(
        url: '/__/proxy/api/insta.json'
        type: 'GET'
        dataType: 'json',
        success: (data) ->
          html = ''
          console.log data
          for i in [0..4]
            html += "<li><img src='#{data[i].image}' alt='feed'/></li>"
          $("#instafeed").html('<ul>' + html + '</ul>')
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
