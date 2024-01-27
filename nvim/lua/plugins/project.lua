local status1, project = pcall(require, "project_nvim")
if not status1 then
    vim.notify("no project_nvim found")
  return
end

-- nvim-tree
vim.g.nvim_tree_respect_buf_cwd = 1

project.setup({
  detection_methods = { "pattern" },
  patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".sln" },
})

local status2, telescope = pcall(require, "telescope")
if not status2 then
  vim.notify("no telescope found")
  return
end
pcall(telescope.load_extension, "projects")
