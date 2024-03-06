return {
  {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    opts = {
      disable_defaults = true,
      language = function() return vim.bo.filetype end,
      output = function() return "./" .. os.date "!%Y-%m-%dT%H-%M-%S" .. "_code.png" end,
    },
  },
}
