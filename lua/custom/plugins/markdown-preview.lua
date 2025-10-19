return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && npm install',
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }

    local function is_wsl()
      if os.getenv 'WSL_DISTRO_NAME' then
        return true
      end
      local uname = (vim.uv or vim.loop).os_uname()
      return uname.release:lower():find 'microsoft' ~= nil
    end

    if is_wsl() then
      _G.mkdp_open_in_explorer = function(url)
        vim.fn.jobstart({ 'explorer.exe', url }, { detach = true })
      end

      vim.cmd [[
        function! MkdpOpenInExplorer(url)
          call luaeval('_G.mkdp_open_in_explorer(_A)', a:url)
        endfunction
      ]]

      vim.g.mkdp_browserfunc = 'MkdpOpenInExplorer'
    end
  end,
  ft = { 'markdown' },
}
