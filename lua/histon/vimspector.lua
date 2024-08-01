local vimspector = {
  toggle_breakpoint = function()
    vim.cmd(':call vimspector#ToggleBreakpoint()')
  end
}

return vimspector
