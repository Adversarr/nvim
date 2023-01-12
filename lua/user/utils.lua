local load_plug = function(name)
    local status, plug = pcall(require, name)
    if not status then
        vim.notify(name .. " not found.", vim.log.levels.WARN)
        return nil
    end
    return plug
end

--[[
Example: 
  wk.register({
    f = {
      name = "file", -- optional group name
      f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
      r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File", noremap=false, buffer = 123 }, -- additional options for creating the keymap
      n = { "New File" }, -- just a label. don't create any mapping
      e = "Edit File", -- same as above
      ["1"] = "which_key_ignore",  -- special label to hide it in the popup
      b = { function() print("bar") end, "Foobar" } -- you can also pass functions!
    },
  }, { prefix = "<leader>" })
]]
local wk_register = function(config)
    local wk = load_plug('which-key')
    if wk == nil then
        vim.notify("Failed to register whichkey")
        return
    end
    wk.register(config)
end

local generate_default_setup = function(plug_name)
  return function()
    local plug = load_plug(plug_name)
    if plug == nil then
      vim.notify("Failed to load " .. plug_name)
      return
    end
    plug.setup{}
  end
end

local default_setup = function(plug_name)
  local setup_function = generate_default_setup(plug_name)
  setup_function()
end

return {
    load_plug = load_plug,
    wk_register = wk_register,
    generate_default_setup = generate_default_setup
}
