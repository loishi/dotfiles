call jetpack#begin()

Jetpack 'neovim/nvim-lspconfig'
Jetpack 'RRethy/nvim-base16'
Jetpack 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Jetpack 'sbdchd/neoformat'
Jetpack 'hrsh7th/nvim-cmp'
Jetpack 'hrsh7th/cmp-nvim-lsp'
Jetpack 'L3MON4D3/LuaSnip'
Jetpack 'saadparwaiz1/cmp_luasnip'
Jetpack 'github/copilot.vim'
Jetpack 'kyazdani42/nvim-web-devicons'
Jetpack 'kyazdani42/nvim-tree.lua'
Jetpack 'akinsho/bufferline.nvim'
Jetpack 'feline-nvim/feline.nvim'
Jetpack 'lukas-reineke/indent-blankline.nvim'
Jetpack 'windwp/nvim-autopairs'
Jetpack 'nvim-lua/plenary.nvim'
Jetpack 'nvim-telescope/telescope.nvim'
Jetpack 'williamboman/nvim-lsp-installer'
Jetpack 'simrat39/rust-tools.nvim'
Jetpack 'olimorris/onedarkpro.nvim'
Jetpack 'RRethy/nvim-base16'
Jetpack 'lewis6991/gitsigns.nvim'


call jetpack#end()

set completeopt=menu,menuone,noselect
set number
set relativenumber
set autoindent
set mouse=a
set smartindent
set termguicolors
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set clipboard=unnamedplus

let g:jetpack#optimization=2

colorscheme onedarkpro
" hi! Normal ctermbg=none ctermfg=none guifg=none guibg=none
" hi! LineNr ctermbg=none ctermfg=none guifg=none guibg=none

imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

lua << EOF
require('onedarkpro').setup({
  colors = {
      bg = "#282c34",
      fg = "#bbc2cf",
      red = "#ff6c6b",
      orange = "#da8548",
      yellow = "#ECBE7B",
      green = "#98be65",
      cyan = "#46D9FF",
      blue = "#51afef",
      purple = "#c678dd",
      white = "#efefef",
      black = "#282c34",
      gray = "#3f444a",
      highlight = "#51afef",
    },
})
vim.o.background = "dark"
require('onedarkpro').load()


vim.opt.list = true
require('gitsigns').setup()
require('indent_blankline').setup()
require('nvim-autopairs').setup{}
require('nvim-tree').setup()
require('bufferline').setup{}
require('feline').setup()
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  }
}

local lsp_installer = require "nvim-lsp-installer"
local servers = {'vimls', 'sumneko_lua', 'clangd', 'rust_analyzer', 'jdtls', 'pyright' }
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end

lsp_installer.on_server_ready(function(server)
  local opts = { capabilities = capabilities,}
  if server.name == "rust_analyzer" then
    require("rust-tools").setup {
      server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
    }
      server:attach_buffers()
      require("rust-tools").start_standalone_if_required()
  else
    server:setup(opts)
  end
end)


local lspconfig = require('lspconfig')


-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
EOF
