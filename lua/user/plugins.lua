local packer_sync_when_startup = false

--[[
  -- NOTE: Plugin Setup Demo:
  use {
    'myusername/example',        -- The plugin location string
    -- The following keys are all optional
    disable = boolean,           -- Mark a plugin as inactive
    as = string,                 -- Specifies an alias under which to install the plugin
    installer = function,        -- Specifies custom installer. See "custom installers" below.
    updater = function,          -- Specifies custom updater. See "custom installers" below.
    after = string or list,      -- Specifies plugins to load before this plugin. See "sequencing" below
    rtp = string,                -- Specifies a subdirectory of the plugin to add to runtimepath.
    opt = boolean,               -- Manually marks a plugin as optional.
    bufread = boolean,           -- Manually specifying if a plugin needs BufRead after being loaded
    branch = string,             -- Specifies a git branch to use
    tag = string,                -- Specifies a git tag to use. Supports '*' for "latest tag"
    commit = string,             -- Specifies a git commit to use
    lock = boolean,              -- Skip updating this plugin in updates/syncs. Still cleans.
    run = string, function, or table, -- Post-update/install hook. See "update/install hooks".
    requires = string or list,   -- Specifies plugin dependencies. See "dependencies".
    rocks = string or list,      -- Specifies Luarocks dependencies for the plugin
    config = string or function, -- Specifies code to run after this plugin is loaded.
    -- The setup key implies opt = true
    setup = string or function,  -- Specifies code to run before this plugin is loaded. The code is ran even if
                                 -- the plugin is waiting for other conditions (ft, cond...) to be met.
    -- The following keys all imply lazy-loading and imply opt = true
    cmd = string or list,        -- Specifies commands which load this plugin. Can be an autocmd pattern.
    ft = string or list,         -- Specifies filetypes which load this plugin.
    keys = string or list,       -- Specifies maps which load this plugin. See "Keybindings".
    event = string or list,      -- Specifies autocommand events which load this plugin.
    fn = string or list          -- Specifies functions which load this plugin.
    cond = string, function, or list of strings/functions,   -- Specifies a conditional test to load this plugin
    module = string or list      -- Specifies Lua module names for require. When requiring a string which starts
                                 -- with one of these module names, the plugin will be loaded.
    module_pattern = string/list -- Specifies Lua pattern of Lua module names for require. When
                                 -- requiring a string which matches one of these patterns, the plugin will be loaded.
  }
]]

-- Bootstrap Packer.
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- TODO: When plugins.lua changes, run packer compile.
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerCompile
--   augroup end
-- ]])
local utils = require('user.utils')
local packer = utils.load_plug('packer')
if packer == nil then
    return
end

-- Initialize Packer:
packer.init({
    ensure_dependencies = true, -- Should packer install plugin dependencies?
    -- snapshot = nil, -- Name of the snapshot you would like to load at startup
    -- snapshot_path = util.join_paths(vim.fn.stdpath('cache'), 'packer.nvim'), -- Default save directory for snapshots
    -- package_root   = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack'),
    -- compile_path = util.join_paths(vim.fn.stdpath('config'), 'plugin', 'packer_compiled.lua'),
    plugin_package = 'packer', -- The default package for plugins
    max_jobs = nil, -- Limit the number of simultaneous jobs. nil means no limit
    auto_clean = true, -- During sync(), remove unused plugins
    compile_on_sync = true, -- During sync(), run packer.compile()
    disable_commands = false, -- Disable creating commands
    opt_default = false, -- Default to using opt (as opposed to start) plugins
    transitive_opt = true, -- Make dependencies of opt plugins also opt by default
    transitive_disable = true, -- Automatically disable dependencies of disabled plugins
    auto_reload_compiled = true, -- Automatically reload the compiled file after creating it.
    preview_updates = false, -- If true, always preview updates before choosing which plugins to update, same as `PackerUpdate --preview`.
    git = {
        cmd = 'git', -- The base command for git operations
        subcommands = { -- Format strings for git subcommands
            update = 'pull --ff-only --progress --rebase=false',
            install = 'clone --depth %i --no-single-branch --progress',
            fetch = 'fetch --depth 999999 --progress',
            checkout = 'checkout %s --',
            update_branch = 'merge --ff-only @{u}',
            current_branch = 'branch --show-current',
            diff = 'log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD',
            diff_fmt = '%%h %%s (%%cr)',
            get_rev = 'rev-parse --short HEAD',
            get_msg = 'log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1',
            submodules = 'submodule update --init --recursive --progress'
        },
        depth = 1, -- Git clone depth
        clone_timeout = 60, -- Timeout, in seconds, for git clones
        default_url_format = 'https://github.com/%s' -- Lua format string used for "aaa/bbb" style plugins
    },
    display = {
        non_interactive = false, -- If true, disable display windows for all operations
        compact = false, -- If true, fold updates results by default
        open_fn = nil, -- An optional function to open a window for packer's display
        open_cmd = '65vnew \\[packer\\]', -- An optional command to open a window for packer's display
        working_sym = '⟳', -- The symbol for a plugin being installed/updated
        error_sym = '✗', -- The symbol for a plugin with an error in installation/updating
        done_sym = '✓', -- The symbol for a plugin which has completed installation/updating
        removed_sym = '-', -- The symbol for an unused plugin which was removed
        moved_sym = '→', -- The symbol for a plugin which was moved (e.g. from opt to start)
        header_sym = '━', -- The symbol for the header line in packer's display
        show_all_info = true, -- Should packer show all update details automatically?
        prompt_border = 'double', -- Border style of prompt popups.
        keybindings = { -- Keybindings for the display window
            quit = 'q',
            toggle_update = 'u', -- only in preview
            continue = 'c', -- only in preview
            toggle_info = '<CR>',
            diff = 'd',
            prompt_revert = 'r'
        }
    },
    luarocks = {
        python_cmd = 'python' -- Set the python command to use for running hererocks
    },
    log = {
        level = 'warn'
    }, -- The default print log level. One of: "trace", "debug", "info", "warn", "error", "fatal".
    profile = {
        enable = false,
        threshold = 1 -- integer in milliseconds, plugins which load faster than this won't be shown in profile output
    },
    autoremove = false -- Remove disabled or unused plugins without prompting the user
})

return packer.startup(function(use)
    use { 'wbthomason/packer.nvim' }
    -- TODO: Add other plugins...
    -- Internal utilities.
    use { "Tastyep/structlog.nvim" }
    use { 'nvim-lua/plenary.nvim' }
    use { 'kyazdani42/nvim-web-devicons' }
    use {
        'rcarriga/nvim-notify'
    }
    use {
        'b0o/schemastore.nvim',
        ft = { 'json' }
    }

    -- General utilities:
    use { 'folke/which-key.nvim' }
    use { 'numToStr/Comment.nvim' }
    -- Dashboard
    use { 'glepnir/dashboard-nvim' }

    -- Color schemes:
    use { 'folke/tokyonight.nvim' }

    -- Telescope:
    use "nvim-telescope/telescope.nvim"
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }
    use { 'fannheyward/telescope-coc.nvim' }


    -- File explorer:
    use {
        'nvim-tree/nvim-tree.lua',
        requires = { 'nvim-tree/nvim-web-devicons' }
    }
    use { 'lewis6991/gitsigns.nvim' }

    -- Status line:
    use 'nvim-lualine/lualine.nvim'
    -- use 'vim-airline/vim-airline'
    -- use 'vim-airline/vim-airline-themes'

    -- Buffer Line:
    use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}

    -- Lsp: will call setup in init.lua,
    -- use 'RRethy/vim-illuminate'
    use {
        'neoclide/coc.nvim',
        branch = "release"
    }
    -- use { 'liuchengxu/vista.vim' }

    -- Treesitter:
    use {
        "nvim-treesitter/nvim-treesitter"
    }

    -- Dap:
    -- TODO:

    -- Toggle Term:
    use 'akinsho/toggleterm.nvim'

    -- glsl:
    use 'tikhomirov/vim-glsl'
    -- Markdown:
    use {
        'preservim/vim-markdown',
        require = 'godlygeek/tabular',
        ft = { 'markdown' }
    }

    -- Edit Enhancing:
    use 'lukas-reineke/indent-blankline.nvim'
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim"
    }
    use {
        'iamcco/markdown-preview.nvim',
        ft = { 'markdown' }
    }
    use {
        'windwp/nvim-autopairs' 
    }
    
    -- Tex & LaTex:
    use {
        'lervag/vimtex',
        ft = { 'tex' }
    }



    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap or packer_sync_when_startup then
        require('packer').sync()
    end
end)
