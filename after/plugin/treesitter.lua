local status, nvim_treesitter_parsers = pcall(require, "nvim-treesitter.parsers")

if (status) then
  local configs = nvim_treesitter_parsers.get_parser_configs()
  configs.tsx.install_info.branch = "main"
end

local status2, nvim_treesitter_configs = pcall(require, "nvim-treesitter.configs")

if (status2) then
  nvim_treesitter_configs.setup {
    highlight = { enable = true, },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn", -- set to `false` to disable one of the mappings
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
  }
end

