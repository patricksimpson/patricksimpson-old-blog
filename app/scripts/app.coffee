APP =
  init: ->
    @loadTwitter()
    @loadInstagram()
    @postMetaDate()

  loadTwitter: ->
    if $('#latesttweet').length > 0
      $.ajax(
        url: '/__/proxy/api/twitter.json'
        type: 'GET'
        dataType: 'json',
        success: (data) ->
          console.log data
          date = moment(data.date).fromNow()
          $("#latesttweet").html("#{data.text} <br>#{date}")
      )

  loadInstagram: ->
    if $('#instafeed').length > 0
      $.ajax(
        url: '/__/proxy/api/insta.json'
        type: 'GET'
        dataType: 'json',
        success: (data) ->
          html = ''
          console.log data
          for i in [0..4]
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
