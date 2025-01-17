local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
  error("This plugin requires nvim-telescope/telescope.nvim")
end

local histon = require 'histon'

return telescope.register_extension {
  exports = { histon = histon }
}
