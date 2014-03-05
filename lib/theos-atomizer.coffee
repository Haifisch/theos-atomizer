TheosAtomizerView = require './theos-atomizer-view'

module.exports =
  theosAtomizerView: null

  activate: (state) ->
    @theosAtomizerView = new TheosAtomizerView(state.theosAtomizerViewState)

  deactivate: ->
    @theosAtomizerView.destroy()

  serialize: ->
    theosAtomizerViewState: @theosAtomizerView.serialize()
