APP =
  init: ->
    @loadTwitter()
    @loadInstagram()
    @postMetaDate()

  loadTwitter: ->
    config =
      'id': '525495582903652352'
      'showRetweet': false
      'domId': 'latesttweet'
      'maxTweets': 1
      'enableLinks': true
    twitterFetcher.fetch(config)

  loadInstagram: ->
    feed = new Instafeed(
      get: 'user',
      userId: 235087439,
      limit: 4,
      sortBy: 'most-recent',
      accessToken: '235087439.467ede5.30038cf5e86144a39b71af2972f3b0e0',
      resolution: 'standard_resolution'
    )
    feed.run()

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
