class InstaPopular.Views.MediaIndex extends Backbone.View
  el: '#app'
  template: JST['media/index']
  initialize: ->
    true
    # $(@el).html(@template())

    # @collection.each(media) =>
    #   view = new PopularList.Views.MediaItem model: InstaPopular.Models.Medium
    #   @$('#popular').append(view.render().el)

