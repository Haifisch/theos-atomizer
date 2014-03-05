TheosAtomizer = require '../lib/theos-atomizer'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "TheosAtomizer", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('theosAtomizer')

  describe "when the theos-atomizer:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.theos-atomizer')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'theos-atomizer:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.theos-atomizer')).toExist()
        atom.workspaceView.trigger 'theos-atomizer:toggle'
        expect(atom.workspaceView.find('.theos-atomizer')).not.toExist()
