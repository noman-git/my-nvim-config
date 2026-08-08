-- I cannot get this to work in Kitty so I am just using terminal bg wallpaper :(((
function ColorMyPencils(color)
	color = color or "rose-pine-moon"
	vim.cmd.colorscheme(color)
end

return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false, -- load immediately
        priority = 1000, -- Ensure it loads first
        config = function()
            require('rose-pine').setup({
                styles = {
                    transparency = true,
                    italic = false,
                },
            })
            ColorMyPencils() -- Apply the color scheme immediately
        end
    }
}
