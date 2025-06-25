local config = {
	cmd = { "C:\\Users\\sand77x\\scoop\\shims\\jdtls.exe" },
	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
}
require("jdtls").start_or_attach(config)
