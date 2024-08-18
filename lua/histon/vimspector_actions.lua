local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'

local function vimspector_actions(opts, vimspector)
  opts = opts or {}
  local histon = pickers.new(
    opts,
    {
      propmt_title = 'Vimspector',
      finder = finders.new_table {
        results = {
          {
            name = "Toggle Breakpoint",
            action = vimspector.toggle_breakpoint
          }
        },
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry.name,
            ordinal = entry.name,
          }
        end
      },
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(
          function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            selection.value.action()
          end
        )
        return true
      end,
    }
  )
  histon:find()
end

local function setup(opts)
  local vimspector = require('histon.vimspector')
  vimspector_actions(opts, vimspector)
end

return setup
