local M = {}

M.navigate = function(dir)
  local statusline_height = 1
  local cmdline_height = vim.o.cmdheight
  local pos = vim.api.nvim_win_get_position(0)
  local row = pos[1]
  local col = pos[2]
  local width = vim.api.nvim_win_get_width(0)
  local height = vim.api.nvim_win_get_height(0)

  local active_socket = vim.split(vim.fn.expand('$TMUX'), ',')[1]

  local pane = vim.fn.expand('$TMUX_PANE')

  if dir[1] == ' -L' then
    if col == 0 then
      local tmux_cmd = string.format('tmux -S %s select-pane -t %s %s', active_socket, pane, dir[1])

      vim.fn.system(tmux_cmd)
    else
      local keys = vim.api.nvim_replace_termcodes('<C-w>h', true, false, true)
      vim.fn.feedkeys(keys)
    end
  elseif dir[1] == ' -R' then
    if col + width == vim.o.columns then
      local tmux_cmd = string.format('tmux -S %s select-pane -t %s %s', active_socket, pane, dir[1])

      vim.fn.system(tmux_cmd)
    else
      local keys = vim.api.nvim_replace_termcodes('<C-w>l', true, false, true)
      vim.fn.feedkeys(keys)
    end
  elseif dir[1] == ' -D' then
    if row + height + statusline_height + cmdline_height == vim.o.lines then
      local tmux_cmd = string.format('tmux -S %s select-pane -t %s %s', active_socket, pane, dir[1])

      vim.fn.system(tmux_cmd)
    else
      local keys = vim.api.nvim_replace_termcodes('<C-w>j', true, false, true)
      vim.fn.feedkeys(keys)
    end
  elseif dir[1] == ' -U' then
    if row == 0 then
      local tmux_cmd = string.format('tmux -S %s select-pane -t %s %s', active_socket, pane, dir[1])

      vim.fn.system(tmux_cmd)
    else
      local keys = vim.api.nvim_replace_termcodes('<C-w>k', true, false, true)
      vim.fn.feedkeys(keys)
    end
  end
end

M.left = function()
  M.navigate({' -L'})
end

M.right = function()
  M.navigate({' -R'})
end

M.up = function()
  M.navigate({' -U'})
end

M.down = function()
  M.navigate({' -D'})
end

return M
