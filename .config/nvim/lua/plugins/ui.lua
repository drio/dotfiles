return {
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.presets.lsp_doc_border = true
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 10000,
      render = "wrapped-compact",
    },
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },
  -- animations
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }
    end,
  },
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    -- https://patorjk.com/software/taag/?ref=devas.life#p=display&f=ANSI%20Shadow&t=Step%20by%20step%2C%20I%E2%80%99ll%20get%20there%20eventually
    opts = function(_, opts)
      local logo = [[
  ███╗   ██╗ ██████╗      ██████╗ ██████╗ ███╗   ███╗██████╗ ██╗      █████╗ ██╗███╗   ██╗███████╗
  ████╗  ██║██╔═══██╗    ██╔════╝██╔═══██╗████╗ ████║██╔══██╗██║     ██╔══██╗██║████╗  ██║██╔════╝
  ██╔██╗ ██║██║   ██║    ██║     ██║   ██║██╔████╔██║██████╔╝██║     ███████║██║██╔██╗ ██║███████╗
  ██║╚██╗██║██║   ██║    ██║     ██║   ██║██║╚██╔╝██║██╔═══╝ ██║     ██╔══██║██║██║╚██╗██║╚════██║
  ██║ ╚████║╚██████╔╝    ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║     ███████╗██║  ██║██║██║ ╚████║███████║
  ╚═╝  ╚═══╝ ╚═════╝      ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚══════╝
                                                                                                  
     ]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },
}
