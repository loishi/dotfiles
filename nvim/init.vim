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
Jetpack 'nvim-lualine/lualine.nvim'
Jetpack 'lewis6991/gitsigns.nvim'
Jetpack 'lukas-reineke/indent-blankline.nvim'
Jetpack 'windwp/nvim-autopairs'
Jetpack 'nvim-lua/plenary.nvim'
Jetpack 'nvim-telescope/telescope.nvim'
Jetpack 'williamboman/nvim-lsp-installer'
Jetpack 'simrat39/rust-tools.nvim'

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

let g:jetpack#optimization=2

colorscheme base16-tomorrow-night
" hi! Normal ctermbg=none ctermfg=none guifg=none guibg=none
" hi! LineNr ctermbg=none ctermfg=none guifg=none guibg=none

imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

lua <<EOF
vim.opt.list = true
vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
  show_end_of_line = true,
}
require('nvim-autopairs').setup{}
require('nvim-tree').setup()
require("bufferline").setup{}
require('gitsigns').setup()
require('lualine').setup{ options = { theme = 'horizon'},}
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
