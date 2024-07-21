local utils = require('user.utils')
local refactor = utils.load_plug('refactoring')
if refactor == nil then
  return
end
refactor.setup {
  prompt_func_return_type = {
    go = false,
    java = false,

    cpp = false,
    c = false,
    h = false,
    hpp = false,
    cxx = false,
  },
  prompt_func_param_type = {
    go = false,
    java = false,

    cpp = false,
    c = false,
    h = false,
    hpp = false,
    cxx = false,
  },
  printf_statements = {},
  print_var_statements = {},
  show_success_message = false, -- shows a message with information about the refactor on success
                                -- i.e. [Refactor] Inlined 3 variable occurrences
}
