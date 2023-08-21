vim.g["conjure#filetype#fennel"] = "conjure.client.fennel.stdio"
vim.g["conjure#client#fennel#stdio#command"] = "make repl"
vim.g["conjure#client#sql#stdio#command"] = "psql postgres"
vim.g["conjure#client#sql#stdio#prompt_pattern"] = "postgres=> "
print("loaded .nvimrc.lua")
