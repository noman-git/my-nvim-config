return {
  "3rd/image.nvim",
  config = function()
    require("image").setup({
      backend = "kitty",  -- Best backend for performance.
      processor = "magick_cli",  -- Use the magick_rock for better performance.
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki" },
        },
        neorg = {
          enabled = true,
          filetypes = { "norg" },
        },
        typst = {
          enabled = true,
          filetypes = { "typst" },
        },
        html = {
          enabled = false,
        },
        css = {
          enabled = false,
        },
      },
      max_width = nil,  -- No restrictions on width.
      max_height = nil,  -- No restrictions on height.
      max_width_window_percentage = nil,  -- No max width based on window percentage.
      max_height_window_percentage = 50,  -- Limit height to 50% of the window height.
      window_overlap_clear_enabled = false,  -- Do not hide images when windows overlap.
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },  -- Ignore certain filetypes for overlapping.
      editor_only_render_when_focused = false,  -- Keep images displayed even if the editor loses focus.
      tmux_show_only_in_active_window = false,  -- Show images in all `tmux` windows, not just active ones.
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },  -- File types to render as images.
    })
  end
}

