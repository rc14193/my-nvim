local M = { 
 "mfussenegger/nvim-dap",

  dependencies = {

    -- fancy UI for the debugger
    {
      "rcarriga/nvim-dap-ui",
      -- stylua: ignore
      keys = {
        { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
        { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
		{ "<F5>", function() require("dap").continue() end, desc = "toggle breakpoint", mode = {"n"} },
		{ "<F10>", function() require("dap").step_over() end, desc = "toggle breakpoint", mode = {"n"} },
		{ "<F11>", function() require("dap").step_into() end, desc = "toggle breakpoint", mode = {"n"} },
		{ "<F12>", function() require("dap").step_out() end, desc = "toggle breakpoint", mode = {"n"} },
		{ "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "toggle breakpoint", mode = {"n"} },
		{ "<leader>dr", function() require("dap").repl.toggle() end, desc = "toggle breakpoint", mode = {"n"} },
      },
      opts = {},
      config = function(_, opts)
        -- setup dap config by VsCode launch.json file
        -- require("dap.ext.vscode").load_launchjs()
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end
		dap.adapters.coreclr = {
		  type = 'executable',
		  command = string.format("%s/netcoredbg", vim.env.netcore),
		  args = {'--interpreter=vscode'}
		}

		dap.configurations.cs = {
		  {
			type = "coreclr",
			name = "launch - netcoredbg",
			request = "launch",
			program = function()
				return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
			end,
		  },
		}
      end,
    },
    },
}

return M