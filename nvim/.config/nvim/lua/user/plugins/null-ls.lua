return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, config)
    -- local null_ls = require "null-ls"

    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      --   null_ls.builtins.formatting.stylua,
      --   null_ls.builtins.formatting.prettier,
    }
    return config
  end,
}
