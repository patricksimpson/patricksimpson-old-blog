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
          date = moment(data.date).fromNow()
          $("#latesttweet").html("<span class='tweet'>#{data.text}</span><br><span class='meta meta--date'>#{date}</span>").linkify()
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
      date = moment(new Date($(@).text())).fromNow()
      if date == 'Invalid date'
        date = $(@).text()

      $(@).text(date)
    )
    $('.post--date').each((i)->
      date = moment(new Date($(@).text())).format('MMMM D, YYYY')
      if date == 'Invalid date'
        date = $(@).text()

      $(@).text(date)
    )
    $('.current-year').each((i)->
      $(@).text(moment().format('YYYY') + '.')
    )

APP.init()
