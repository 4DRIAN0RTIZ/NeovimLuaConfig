-- ~/.config/nvim/lua/config/plugins.lua
local fn = vim.fn
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
  vim.cmd [[packadd packer.nvim]]
end

return require("packer").startup(function(use)
  use "wbthomason/packer.nvim"
  use { "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" }
  use { "akinsho/toggleterm.nvim" }
  use "weirongxu/plantuml-previewer.vim"
  use "tyru/open-browser.vim"
  use "wuelnerdotexe/vim-astro"
  use "jackMort/ChatGPT.nvim"
  use "nvim-lua/plenary.nvim"
  use "MunifTanjim/nui.nvim"
  use "github/copilot.vim"
  use "leafOfTree/vim-matchtag"
  use "sainnhe/gruvbox-material"
  use "morhetz/gruvbox"
  use { "folke/tokyonight.nvim", branch = "main" }
  use "dracula/vim"
  use { "catppuccin/nvim", as = "catppuccin" }
  use "williamboman/nvim-lsp-installer"
  use "neovim/nvim-lspconfig"
  use "StanAngeloff/php.vim"
  use "folke/which-key.nvim"
  use "folke/trouble.nvim"
  use "nvim-tree/nvim-web-devicons"
  use "rcarriga/nvim-notify"
  use "folke/noice.nvim"
  use "KabbAmine/vCoolor.vim"
  use "nvim-telescope/telescope.nvim"
  use { "nvim-telescope/telescope-live-grep-args.nvim", branch = "master" }
  use { "neoclide/coc.nvim", branch = "release" }
  use { "neoclide/coc-prettier", run = "yarn install --frozen-lockfile" }
  use "mattn/emmet-vim"
  use "mhartington/formatter.nvim"
  use "sheerun/vim-polyglot"
  use "hrsh7th/vim-vsnip"
  use "hrsh7th/vim-vsnip-integ"
  use "tpope/vim-commentary"
  use "alvan/vim-closetag"
  use "Yggdroot/indentLine"
  use { "nvim-lualine/lualine.nvim", requires = { "nvim-tree/nvim-web-devicons", opt = true } }
  -- use "vim-airline/vim-airline"
  -- use "vim-airline/vim-airline-themes"
  use "nvim-tree/nvim-tree.lua"
  use "othree/html5.vim"
end)
