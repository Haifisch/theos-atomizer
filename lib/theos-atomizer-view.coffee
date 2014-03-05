{$,BufferedProcess,View,EditorView} = require 'atom'
require 'shelljs/global'

module.exports =
class TheosAtomizerView extends View
  @content: ->
      @div class: 'theos-atomizer overlay from-top', =>
        @subview 'miniEditor', new EditorView(mini: true)
        @div class: 'error', outlet: 'error'
        @div class: 'message', outlet: 'message'

  initialize: (serializeState) ->
    atom.workspaceView.command "theos-atomizer:build", => @attach()
    @miniEditor.hiddenInput.on 'focusout', => @detach()
    @on 'core:confirm', => @build()
    @on 'core:cancel', => @detach()
  # Returns an object that can be retrieved when package is activated
  serialize: ->

  attach: ->
    @previouslyFocusedElement = $(':focus')
    @message.text("Enter device IP")
    atom.workspaceView.append(this)
    @miniEditor.focus()

  # Tear down any state and detach
  destroy: ->
    @detach()

  build: (callback) ->
    deviceIP = @miniEditor.getText()
    console.log "Device IP: #{deviceIP}"
    console.log atom.project.getPath()
    cd(atom.project.getPath())
    exec "make package install", (code, output) ->
        console.log "Exit code:", code
        console.log "Program output:", output
