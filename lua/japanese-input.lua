local M = {
	jp_mode = false,
}
local DEFAULT_OPTS = {
	japanese_ime = "com.apple.inputmethod.Kotoeri.RomajiTyping.Japanese",
	english_ime = "com.apple.keylayout.US",
	command = "macism",
	key = "<leader>ij",
	timeout = 3000,
}

function M.switch(command, ime)
	vim.system({ command, ime })
end

function M.prime_japanese(timeout)
	M.jp_mode = true
	vim.defer_fn(function()
		M.jp_mode = false
	end, timeout)
end

function M.setup(opts)
	opts = vim.tbl_deep_extend("force", DEFAULT_OPTS, opts or {})

	vim.keymap.set("n", opts.key, function()
		M.prime_japanese(opts.timeout)
	end, {
		desc = "Enter JP Mode",
		silent = true,
	})
	vim.api.nvim_create_autocmd({ "InsertLeave" }, {
		callback = function()
			M.switch(opts.command, opts.english_ime)
		end,
		desc = "Automatically return to English after leaving insert mode.",
	})
	vim.api.nvim_create_autocmd({ "InsertEnter" }, {
		callback = function()
			if M.jp_mode then
				M.switch(opts.command, opts.japanese_ime)
			end
		end,
		desc = "If jp mode is primed, enter japanese input mode.",
	})
	local ok, wk = pcall(require, "which-key")
	if ok then
		wk.add({ opts.key, icon = "🇯🇵" })
	end
end

return M
