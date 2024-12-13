-- "gc" to comment visual regions/lines
return {
	"numToStr/Comment.nvim",
	config = function()
		local comment = require("Comment")
		comment.setup({
			toggler = {
				block = "gB",
			},
			opleader = {
				block = "gB",
			},
		})
	end,
	opts = {},
}
