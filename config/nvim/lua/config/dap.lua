local dap = require("dap")

--- @type dap.Adapter
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.expand("$MASON/bin/codelldb"),
    args = { "--port", "${port}" },
  },
}

dap.configurations.rust = {
  ---@type dap.Configuration
  {
    name = "Rust debug",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = true,
    showDisassembly = "never",
  },
}

-- Integration with the dap actions
local dapui = require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
