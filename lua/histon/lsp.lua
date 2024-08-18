local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'

local function list_lsp_clients()
  local clients = vim.lsp.get_active_clients({bufnr = vim.fn.bufnr()})
  local results = {}
  for _, client in ipairs(clients) do
    table.insert(
      results,
      {
        name = client.name,
        actions = {
          {
            name = "Restart LSP Client",
            action = function()
              vim.lsp.stop_client(client.id)
              vim.lsp.start_client(client.config)
            end
          }
        }
      }
    )
  end
  return results
end

local function lsp_client_actions(opts, client)
  opts = opts or {}
  local lsp = pickers.new(
    opts,
    {
      prompt_title = client.name,
      finder = finders.new_table {
        results = client.actions,
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
  lsp:find()
end

local function lsp_clients_pick(opts)
  opts = opts or {}
  local lsp = pickers.new(
    opts,
    {
      prompt_title = 'LSP Clients',
      finder = finders.new_table {
        results = list_lsp_clients(),
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
            -- actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            lsp_client_actions(opts, selection.value)
          end
        )
        return true
      end,
    }
  )
  lsp:find()
end

return lsp_clients_pick
