return {
  vimspector =
    function (opts)
      local vimspector = require('histon.vimspector')
      local vimspector_actions = require('histon.vimspector_actions')
      vimspector_actions(opts, vimspector)
    end,
  lsp = 
    function (opts)
      local lsp_actions = require('histon.lsp')
      lsp_actions(opts)
    end
}
