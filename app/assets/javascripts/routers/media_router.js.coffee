class InstaPopular.Routers.Media extends Backbone.Router
  routes:
    '' :'index'

  index: ->
    media_files = new PopularList.Collections.Media
    new PopularList.Views.Media collection: media_files
    media_files.fetch()
