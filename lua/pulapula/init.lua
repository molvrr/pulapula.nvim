local M = {}

M.navigate = function(dir)
  local tmux = os.getenv('TMUX')
  local statusline_height = 1
  local cmdline_height = vim.o.cmdheight
  local pos = vim.api.nvim_win_get_position(0)
  local width = vim.api.nvim_win_get_width(0)
  local height = vim.api.nvim_win_get_height(0)
  local active_socket = vim.split(vim.fn.expand('$TMUX'), ',')[1]
  local pane = vim.fn.expand('$TMUX_PANE')
  local tmux_cmd = string.format('tmux -S %s select-pane -t %s -%s', active_socket, pane, dir)

  if dir == 'L' then
    if pos[2] == 0 and tmux then
      vim.fn.system(tmux_cmd)
    else
      vim.cmd.wincmd('h')
    end
  elseif dir == 'R' then
    if pos[2] + width == vim.o.columns and tmux then
      vim.fn.system(tmux_cmd)
    else
      vim.cmd.wincmd('l')
    end
  elseif dir == 'U' then
    if pos[1] == 0 and tmux then
      vim.fn.system(tmux_cmd)
    else
      vim.cmd.wincmd('k')
    end
  elseif dir == 'D' then
    if pos[1] + height + statusline_height + cmdline_height == vim.o.lines and tmux then
      vim.fn.system(tmux_cmd)
    else
      vim.cmd.wincmd('j')
    end
  end
end

M.maximize = function()
  local tmux = os.getenv('TMUX')
  local windows = vim.api.nvim_tabpage_list_wins(0)
  local active_socket = vim.split(vim.fn.expand('$TMUX'), ',')[1]

  if #windows == 1 and tmux then
    vim.fn.system(string.format('tmux -S %s resize-pane -Z', active_socket))
  else
    vim.cmd.only()
  end
end

return M
