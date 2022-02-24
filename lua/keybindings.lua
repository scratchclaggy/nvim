local nest = require("nest")
vim.g.yoinkIncludeDeleteOperations = 1

local replace_termcodes = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local s_tab_complete = function()
  if vim.fn["vsnip#jumpable"](-1) == 1 then
    vim.fn.feedkeys(replace_termcodes("<Plug>(vsnip-jump-prev)"), "")
    return ""
  end
end

local tab_complete = function()
  if vim.fn["vsnip#available"](1) == 1 then
    vim.fn.feedkeys(replace_termcodes("<Plug>(vsnip-expand-or-jump)"), "")
    return ""
  else
    return replace_termcodes("<Tab>")
  end
end

nest.applyKeymaps({
	{
		"<leader>",
		{
			{ "bd", "<cmd>bd<cr>" },
			{ "e", "<cmd>Trouble<cr>" },
			{
				"f",
				{
					{ "f", "<cmd>Telescope find_files<cr>" },
					{ "h", "<cmd>Telescope help_tags<cr>" },
					{ "j", "<cmd>Telescope buffers<cr>" },
					{ "l", "<cmd>Telescope live_grep<cr>" },
					{ "m", "<cmd>lua vim.lsp.buf.formatting_sync()<cr>" },
				},
			},
			{ "g", "<cmd>tab G<cr>" },
			{
				"s",
				{
					{ "a", "gg0vG$" },
					{ "h", "<cmd>FocusSplitLeft<cr>" },
					{ "j", "<cmd>FocusSplitDown<cr>" },
					{ "k", "<cmd>FocusSplitUp<cr>" },
					{ "l", "<cmd>FocusSplitRight<cr>" },
				},
			},
			{ "rn", "<cmd>lua vim.lsp.buf.rename()<cr>" },
			{ "qn", "<cmd>wqa<cr>" },
			{ "w", "<cmd>w<cr>" },
			{ "x", "<c-w>q" },
		},
	},
	{ "gd", "<cmd>lua vim.lsp.buf.definition()<CR>" },
	{ "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>" },
	{ "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>" },
	{ "K", "<cmd>lua vim.lsp.buf.hover()<cr>" },
	{ "Q", "<nop>" }, 
    {
        mode = "is",
        options = {expr = true},
        {
          {"<tab>", tab_complete},
          {"<s-tab>", s_tab_complete}
        }
    },
	{ "<tab>", "<cmd>b#<cr>" },
	{ "<s-tab>", "<cmd>bprevious<cr>" },
	{ "<", "<gv", mode = "v" },
	{ ">", ">gv", mode = "v" },
	{
		"<c-",
		{ { "h>", "<c-w>h" }, { "j>", "<c-w>j" }, { "k>", "<c-w>k" }, { "l>", "<c-w>l" } },
	},
	-- Cutlass / Yoink / Subversive
	{ "x", "d", mode = "nx" },
	{ "xx", "dd" },
	{ "X", "D" },
	{ "Y", "y$" },
	{
		options = { noremap = false },
		{
			{ "s", "<plug>(SubversiveSubstitute)", mode = "nx" },
			{ "ss", "<plug>(SubversiveSubstituteLine)" },
			{ "S", "<plug>(SubversiveSubstituteToEndOfLine)" },
			{ "p", "<plug>(YoinkPaste_p)" },
			{ "p", "<plug>(SubversiveSubstitute)", mode = "x" },
			{ "P", "<plug>(YoinkPaste_P)" },
			{ "P", "<plug>(SubversiveSubstitute)", mode = "x" },
			{ "<c-n>", "<Plug>(YoinkPostPasteSwapBack)" },
			{ "<c-p>", "<Plug>(YoinkPostPasteSwapForward)" },
		},
	},
})
