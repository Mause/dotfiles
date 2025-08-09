local dap = require('dap')

--- @type dap.Adapter
dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = vim.fn.expand '$MASON/bin/codelldb',
    args = { "--port", "${port}" },
  }
}

dap.configurations.rust = {
  ---@type dap.Configuration
  {
    name = "Rust debug",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
    showDisassembly = 'never',
  },
}
