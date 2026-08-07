return {
  {
    "benlubas/image-save.nvim",
    -- enabled = false,
    -- dev = true,
    cmd = "SaveImage",
  },
  {
    "3rd/image.nvim",
    -- "benlubas/image.nvim",
    -- dev = true,
    -- enabled = false,
    -- The magick_cli processor shells out to the ImageMagick binary, so the magick
    -- luarock is dead weight. Removing the explicit dependency is not enough on its
    -- own: image.nvim ships a rockspec that declares magick, and lazy honours it by
    -- setting build = "rockspec" and pulling in hererocks. build = false overrides
    -- that.
    build = false,
    ft = { "markdown", "norg" },
    config = function()
      local image = require("image")

      ---@diagnostic disable-next-line: missing-fields
      image.setup({
        backend = "kitty",
        processor = "magick_cli",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = false,
            only_render_image_at_cursor = false,
            filetypes = { "markdown", "quarto" }, -- markdown extensions (ie. quarto) can go here
          },
          neorg = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = false,
            only_render_image_at_cursor = false,
            filetypes = { "norg" },
          },
        },
        max_width = 100,
        max_height = 8,
        max_height_window_percentage = math.huge,
        max_width_window_percentage = math.huge,
        window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
        editor_only_render_when_focused = true, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "fidget", "" },
      })
    end,
  },
  { "3rd/diagram.nvim", dependencies = { "image.nvim" }, enabled = false, opts = {} },
}
