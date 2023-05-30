local dirs = function()
  local pos = vim.api.nvim_win_get_position(0)
  local width = vim.api.nvim_win_get_width(0)
  local height = vim.api.nvim_win_get_height(0)

  return {
    L = { key = 'h', move = pos[2] == 0 },
    R = { key = 'l', move = pos[2] + width == vim.o.columns },
    U = { key = 'k', move = pos[1] == 0 },
    D = { key = 'j', move = pos[1] + height + 1 + vim.o.cmdheight == vim.o.lines }
  }
end

local navigate = function(dir)
  local tmux = os.getenv('TMUX')
  local active_socket = vim.split(vim.fn.expand('$TMUX'), ',')[1]
  local pane = vim.fn.expand('$TMUX_PANE')
  local tmux_cmd = string.format('tmux -S %s select-pane -t %s -%s', active_socket, pane, dir)
  local zoomed = string.match(vim.fn.system("tmux list-panes -F '#F'"), 'Z')
  local should_move = tmux and not (zoomed and not vim.g.pulapula_ignore_zoom) and dirs()[dir].move

  if should_move then
    return vim.fn.system(tmux_cmd)
  else
    vim.cmd.wincmd(dirs()[dir].key)
  end
end

local maximize = function()
  local tmux = os.getenv('TMUX')
  local windows = vim.api.nvim_tabpage_list_wins(0)
  local active_socket = vim.split(vim.fn.expand('$TMUX'), ',')[1]

  if #windows == 1 and tmux then
    vim.fn.system(string.format('tmux -S %s resize-pane -Z', active_socket))
  else
    vim.cmd.only()
  end
end

return {
  maximize = maximize,
  navigate = navigate,
}
