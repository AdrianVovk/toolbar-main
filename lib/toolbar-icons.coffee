module.exports =
  config:
    pushWithCommit:
      type: 'boolean'
      default: true
      title: 'Commit and Push'
      description: 'The "Commit" button in the toolbar also pushes the project to the remote repository'

  activate: (state) ->


  deactivate: ->
    @toolBar?.removeItems()

  serialize: ->

  consumeToolBar: (getToolBar) ->
    @toolBar = getToolBar 'toolbar-icons'

    console.log 'TESTING'

    @toolBar.addButton
      icon: 'plus'
      callback: 'tree-view:add-file' # TODO do not use this make cusom version and use eventually.
      tooltip: 'New File'
      iconset: 'mdi'

    @toolBar.addButton
      icon: 'content-save'
      callback: 'project-plus:save'
      tooltip: 'Save Project'
      iconset: 'mdi'

    @toolBar.addButton
      icon: 'folder'
      callback: 'project-plus:toggle-project-finder'
      tooltip: 'Open...'
      iconset: 'mdi'

    @toolBar.addSpacer()

    @toolBar.addButton
      icon: 'play'
      callback: ->
          atom.notifications.addWarning('Run feature coming soon!', null)
      tooltip: 'Run'
      iconset: 'mdi'

    @toolBar.addButton
      icon: 'bug'
      callback: ->
          atom.notifications.addWarning('Debug feature coming soon!', null)
      tooltip: 'Debug'
      iconset: 'mdi'

    # TODO: Modify project-plus to support service callback whenever a session changes and add a way to check if the current session is using version control.
    # TODO: Modify git-plus to make it more generic and usable
    if true
      #Time for some Git controls
      @toolBar.addSpacer()

      @toolBar.addButton
        icon: 'git'
        callback: ->
            atom.notifications.addWarning('HI', null)
        tooltip: 'Git Menu'
        iconset: 'mdi'

      @toolBar.addButton
        icon: 'upload'
        callback: ->
          editorElement = atom.views.getView(atom.workspace.getActiveTextEditor())
          if atom.config.get("toolbar-icons.pushWithCommit")
            atom.commands.dispatch(editorElement, 'git-plus:add-all-commit-and-push')
          else
            atom.commands.dispatch(editorElement, 'git-plus:add-all-and-commit')
        tooltip: 'Commit'
        iconset: 'mdi'

      @toolBar.addButton
        icon: 'download'
        callback: 'git-plus:pull'
        tooltip: 'Pull'
        iconset: 'mdi'

    @toolBar.addSpacer()

    @toolBar.addButton
      icon: 'settings'
      callback: 'settings-view:open'
      tooltip: 'Open Settings View'
      iconset: 'mdi'

    if atom.inDevMode()

      @toolBar.addButton
        icon: 'refresh'
        callback: 'window:reload'
        tooltip: 'Reload Window'
        iconset: 'mdi'

      @toolBar.addButton
        icon: 'code-tags'
        callback: ->
          require('remote').getCurrentWindow().toggleDevTools()
        tooltip: 'Toggle Developer Tools'
        iconset: 'mdi'
