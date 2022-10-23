local status, wk = pcall(require, "which-key")

if (not status) then return end

wk.register({
  f = {
    name = "file",
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
    l = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
  },
}, { prefix= "<leader>"})
