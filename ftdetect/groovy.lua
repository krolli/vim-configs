vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
	pattern = "*.Jenkinsfile",
	command = "set filetype=groovy",
})
