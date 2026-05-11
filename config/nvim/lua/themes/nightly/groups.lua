local theme = {}

function theme.setup()
  local options = require("themes.nightly.config").options
  local p = require("themes.nightly.palete").dark_colors

  if options.transparent then
    p.linenr = p.fg_bright
    p.background = "NONE"
    vim.o.pumblend = 0
  end

  theme.highlights = {
    -- Base highlights
    Boolean                     = { fg = p.keyword },
    Character                   = { fg = p.method },
    ColorColumn                 = { bg = p.light_bg },
    Comment                     = { fg = p.comment_muted, style = options.styles.comments },
    Conceal                     = { fg = p.tag, bg = p.background },
    Conditional                 = { fg = p.func },
    Constant                    = { fg = p.keyword },
    Cursor                      = { fg = p.foreground, bg = p.foreground },
    CurSearch                   = { link = "IncSearch" },
    CursorColumn                = { bg = p.background },
    CursorIM                    = { fg = p.foreground, bg = p.foreground },
    CursorLine                  = { bg = p.light_bg },
    CursorLineNr                = { fg = p.foreground_hl },
    Debug                       = { fg = p.error },
    Define                      = { fg = p.keyword },
    Delimiter                   = { fg = p.foreground },
    DiffAdd                     = { bg = "#0d2119" },
    DiffChange                  = { bg = "#192231" },
    DiffDelete                  = { bg = "#3b0c14" },
    DiffText                    = { bg = "#253a5e" },
    Directory                   = { fg = p.subtle },
    EndOfBuffer                 = { fg = p.background },
    Error                       = { fg = p.error, bg = p.background },
    ErrorMsg                    = { fg = p.error, bg = p.background },
    Exception                   = { fg = p.func },
    Float                       = { fg = p.keyword },
    FloatBorder                 = { fg = p.subtle },
    FoldColumn                  = { fg = p.tag, bg = p.background },
    Folded                      = { fg = p.tag, bg = p.background },
    Function                    = { fg = p.func, style = options.styles.functions },
    Identifier                  = { fg = p.keyword },
    Ignore                      = { fg = p.variable, bg = p.background },
    IncSearch                   = { fg = p.black, bg = p.match },
    Include                     = { fg = p.func },
    Keyword                     = { fg = p.func, style = options.styles.keywords },
    Label                       = { fg = p.tag },
    LineNr                      = { fg = p.subtle, bg = p.darker_bg },
    Macro                       = { fg = p.func },
    MatchParen                  = { fg = p.tag, bg = p.background },
    ModeMsg                     = { fg = p.foreground, bg = p.background },
    MoreMsg                     = { fg = p.keyword },
    MsgArea                     = { fg = p.foreground, bg = p.background },
    MsgSeparator                = { fg = p.foreground, bg = p.background },
    NonText                     = { fg = p.error },
    Normal                      = { fg = p.foreground, bg = p.background },
    NormalFloat                 = { bg = p.background },
    NormalNC                    = { fg = p.foreground, bg = p.background },
    Number                      = { fg = p.type },
    Operator                    = { fg = p.func },
    Pmenu                       = { fg = p.subtle, bg = p.background },
    PmenuSbar                   = { bg = p.background },
    PmenuSel                    = { fg = p.black, bg = p.tag },
    PmenuThumb                  = { bg = p.string },
    PreCondit                   = { fg = p.func },
    PreProc                     = { fg = p.func },
    Question                    = { fg = p.keyword },
    QuickFixLine                = { bg = p.cursorline },
    qfLineNr                    = { fg = p.tag },
    Repeat                      = { fg = p.func },
    Search                      = { fg = p.black, bg = p.tag },
    SignColumn                  = { bg = p.darker_bg },
    Special                     = { fg = p.func },
    SpecialChar                 = { fg = p.foreground },
    SpecialComment              = { fg = p.string },
    SpecialKey                  = { fg = p.tag },
    SpellBad                    = { fg = p.string },
    SpellCap                    = { fg = p.func },
    SpellLocal                  = { fg = p.tag },
    SpellRare                   = { fg = p.func },
    Statement                   = { fg = p.func },
    StatusLine                  = { fg = p.foreground, bg = p.background },
    StatusLineNC                = { bg = p.background, fg = p.background },
    Storage                     = { fg = p.namespace },
    StorageClass                = { fg = p.keyword },
    String                      = { fg = p.string },
    Structure                   = { fg = p.func },
    Substitute                  = { fg = p.black, bg = p.namespace },
    TabLine                     = { fg = p.string, bg = p.background },
    TabLineFill                 = { fg = p.foreground, bg = p.background },
    TabLineSel                  = { fg = p.foreground, bg = p.background },
    Tag                         = { fg = p.tag },
    TermCursor                  = { fg = p.foreground, bg = p.foreground },
    TermCursorNC                = { fg = p.foreground, bg = p.foreground },
    Title                       = { fg = p.tag, bold = true },
    Todo                        = { fg = p.error, bg = p.background },
    Type                        = { fg = p.type },
    Typedef                     = { fg = p.type },
    Underlined                  = { fg = p.string, underline = true },
    Variable                    = { fg = p.keyword },
    VertSplit                   = { fg = p.border },
    Visual                      = { bg = p.cursorline },
    VisualNOS                   = { bg = p.background },
    WarningMsg                  = { fg = p.type, bg = p.background },
    WinSeparator                = { fg = p.border, bg = p.background },
    Whitespace                  = { fg = p.error },
    WildMenu                    = { fg = p.variable, bg = p.tag },
    lCursor                     = { fg = p.foreground, bg = p.foreground },

    --
    WinBar                      = { bg = p.background, fg = p.foreground },
    WinBarNC                    = { bg = p.background, fg = p.foreground },

    -- Fzf
    FzfLuaPreviewTitle          = { fg = p.foreground, bg = p.darker_bg },
    FzfLuaPreviewBorder         = { fg = p.foreground, bg = p.darker_bg },
    FzfLuaFzfScrollbar          = { fg = p.background, bg = p.background },

    -- bufferline.nvim: https://github.com/akinsho/bufferline.nvim
    BufferLineFill              = { bg = p.bg_panel },
    BufferLineIndicatorSelected = { fg = p.string },

    -- Diagnostic
    DiagnosticError             = { fg = p.error },
    DiagnosticHint              = { fg = p.string },
    DiagnosticInfo              = { fg = p.tag },
    DiagnosticWarn              = { fg = p.type },
    DiagnosticUnnecessary       = { fg = p.none },

    -- diff
    diffAdded                   = { fg = p.tag },
    diffChanged                 = { fg = p.keyword },
    diffFile                    = { fg = p.variable },
    diffIndexLine               = { fg = p.func },
    diffLine                    = { fg = p.error },
    diffNewFile                 = { fg = p.keyword },
    diffOldFile                 = { fg = p.keyword },
    diffRemoved                 = { fg = p.error },

    -- gitsigns: https://github.com/lewis6991/gitsigns.nvim
    GitSignsAdd                 = { fg = p.tag },
    GitSignsChange              = { fg = p.keyword },
    GitSignsDelete              = { fg = p.error },

    -- LSP
    LspInfoFiletype             = { fg = p.fg_bright },
    LspReferenceText            = { bg = p.ref_bg },
    LspReferenceRead            = { bg = p.ref_bg },
    LspReferenceWrite           = { bg = p.ref_bg },
    LspInfoBorder               = { link = "FloatBorder" },

    -- lspsaga.nvim: https://github.com/glepnir/lspsaga.nvim
    DefinitionCount             = { fg = p.func },
    DefinitionIcon              = { fg = p.variable },
    LspFloatWinBorder           = { link = "FloatBorder" },
    LspFloatWinNormal           = { bg = p.background },
    LspSagaBorderTitle          = { fg = p.variable },
    LspSagaCodeActionBorder     = { link = "FloatBorder" },
    LspSagaCodeActionContent    = { fg = p.func },
    LspSagaCodeActionTitle      = { fg = p.variable },
    LspSagaDefPreviewBorder     = {},
    LspSagaFinderSelection      = { fg = p.error },
    LspSagaHoverBorder          = { link = "FloatBorder" },
    LspSagaRenameBorder         = { link = "FloatBorder" },
    LspSagaSignatureHelpBorder  = { link = "FloatBorder" },
    ReferencesCount             = { fg = p.func },
    ReferencesIcon              = { fg = p.variable },
    TargetWord                  = { fg = p.variable },
    SagaText                    = { fg = p.variable },
    SagaFileName                = { fg = p.variable },
    SagaFolderName              = { fg = p.variable },

    -- Neogit: https://github.com/TimUntersberger/neogit
    NeogitBranch                = { fg = p.func },
    NeogitDiffAddHighlight      = { fg = p.black, bg = p.tag },
    NeogitDiffContextHighlight  = { bg = p.background, fg = p.foreground },
    NeogitDiffDeleteHighlight   = { fg = p.black, bg = p.error },
    NeogitHunkHeader            = { bg = p.black, fg = p.foreground },
    NeogitHunkHeaderHighlight   = { bg = p.comment, fg = p.variable },
    NeogitRemote                = { fg = p.func },

    --Neotree
    NeoTreeDirectoryName        = { fg = p.foreground_hl },


    -- Neovim
    healthError                = { fg = p.error },
    healthSuccess              = { fg = p.tag },
    healthWarning              = { fg = p.keyword },

    -- nvim-cmp: https://github.com/hrsh7th/nvim-cmp
    CmpDocumentationBorder     = { fg = p.subtle, bg = p.background },
    CmpItemAbbr                = { fg = p.foreground, bg = p.background },
    CmpItemAbbrDeprecated      = { fg = p.string, bg = p.background },
    CmpItemAbbrMatch           = { fg = p.variable, bg = p.background },
    CmpItemAbbrMatchFuzzy      = { fg = p.variable, bg = p.background },
    CmpItemKind                = { fg = p.tag, bg = p.background },
    CmpItemMenu                = { fg = p.string, bg = p.background },
    CmpItemKindFolder          = { fg = p.tag },
    CmpItemKindFile            = { fg = p.string },
    CmpItemKindConstructor     = { fg = p.keyword },
    CmpItemKindInterface       = { fg = p.keyword },
    CmpItemKindReference       = { fg = p.keyword },
    CmpItemKindConstant        = { fg = p.keyword },
    CmpItemKindProperty        = { fg = p.keyword },
    CmpItemKindModule          = { fg = p.keyword },
    CmpItemKindClass           = { fg = p.keyword },
    CmpItemKindField           = { fg = p.keyword },
    CmpItemKindEvent           = { fg = p.keyword },
    CmpItemKindSnippet         = { fg = p.tag },
    CmpItemKindKeyword         = { fg = p.tag },
    CmpItemKindValue           = { fg = p.tag },
    CmpItemKindOperator        = { fg = p.tag },
    CmpItemKindTypeParameter   = { fg = p.variable },
    CmpItemKindVariable        = { fg = p.variable },
    CmpItemKindText            = { fg = p.variable },
    CmpItemKindUnit            = { fg = p.variable },

    -- Yank
    YankyPut                   = { link = "Visual" },
    YankyYanked                = { link = "Visual" },
    YankHighlight              = { bg = p.cursorline },

    -- Markdown
    markdownCodeBlock          = { fg = p.variable },
    markdownCodeDelimeter      = { fg = p.variable },
    markdownUrl                = { fg = p.fg_bright },
    markdownLink               = { fg = p.foreground, underline = true },

    -- nvim-tree.lua: https://github.com/nvim-tree/nvim-tree.lua
    NvimTreeEmptyFolderName    = { fg = p.foreground },
    NvimTreeEndOfBuffer        = { fg = p.foreground, bg = p.background },
    NvimTreeEndOfBufferNC      = { fg = p.foreground, bg = p.background },
    NvimTreeFolderIcon         = { fg = p.subtle, bg = p.background },
    NvimTreeFolderName         = { fg = p.foreground },
    NvimTreeGitDeleted         = { fg = p.error },
    NvimTreeGitDirty           = { fg = p.keyword },
    NvimTreeGitNew             = { fg = p.tag },
    NvimTreeImageFile          = { fg = p.foreground },
    NvimTreeIndentMarker       = { fg = p.border },
    NvimTreeNormal             = { fg = p.foreground, bg = p.background },
    NvimTreeNormalNC           = { fg = p.foreground, bg = p.background },
    NvimTreeOpenedFolderName   = { fg = p.foreground },
    NvimTreeRootFolder         = { fg = p.subtle },
    NvimTreeSpecialFile        = { fg = p.error },
    NvimTreeStatusLineNC       = { bg = p.background, fg = p.background },
    NvimTreeSymlink            = { fg = p.type },
    NvimTreeWinSeparator       = { fg = p.background },

    -- nvim-treesitter: https://github.com/nvim-treesitter/nvim-treesitter
    -- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md
    ["@attribute"]             = { fg = p.tag },
    ["@boolean"]               = { fg = p.keyword },
    ["@character"]             = { fg = p.tag },
    ["@comment"]               = { fg = p.comment_muted, style = options.styles.comments },
    ["@conditional"]           = { fg = p.error },
    ["@constant"]              = { fg = p.func },
    ["@constant.builtin"]      = { fg = p.tag },
    ["@constant.macro"]        = { fg = p.type },
    ["@constructor"]           = { fg = p.tag },
    ["@exception"]             = { fg = p.error },
    ["@field"]                 = { fg = p.variable },
    ["@float"]                 = { link = "@number" },
    ["@function"]              = { fg = p.func, style = options.styles.functions },
    ["@function.builtin"]      = { fg = p.builtin },
    ["@function.macro"]        = { fg = p.string },
    ["@include"]               = { fg = p.tag },
    ["@keyword"]               = { fg = p.keyword, style = options.styles.keywords },
    ["@keyword.function"]      = { fg = p.keyword, style = options.styles.functions },
    ["@keyword.operator"]      = { fg = p.method },
    ["@keyword.return"]        = { fg = p.tag },
    ["@label"]                 = { fg = p.tag },
    ["@method"]                = { fg = p.method },
    ["@namespace"]             = { fg = p.namespace },
    ["@number"]                = { fg = p.func },
    ["@operator"]              = { fg = p.variable },
    ["@parameter"]             = { fg = p.variable },
    ["@parameter.reference"]   = { fg = p.namespace },
    ["@property"]              = { fg = p.variable },
    ["@punctuation.bracket"]   = { fg = p.variable },
    ["@punctuation.delimiter"] = { fg = p.variable },
    ["@punctuation.special"]   = { fg = p.variable },
    ["@repeat"]                = { fg = p.term_purple },
    ["@string"]                = { fg = p.string },
    ["@string.escape"]         = { fg = p.tag },
    ["@string.regex"]          = { fg = p.string },
    ["@string.special"]        = { fg = p.tag },
    ["@symbol"]                = { fg = p.error },
    ["@tag"]                   = { fg = p.tag },
    ["@tag.attribute"]         = { fg = p.error },
    ["@tag.delimiter"]         = { fg = p.variable },
    ["@text"]                  = { fg = p.variable },
    ["@text.danger"]           = { fg = p.overlay },
    ["@text.emphasis"]         = { fg = p.variable, italic = true },
    ["@text.environment.name"] = { fg = p.type },
    ["@text.environtment"]     = { fg = p.keyword },
    ["@text.literal"]          = { fg = p.string, italic = true },
    ["@text.math"]             = { fg = p.func },
    ["@text.note"]             = { fg = p.black, bg = p.string },
    ["@text.reference"]        = { fg = p.func },
    ["@text.strike"]           = { fg = p.variable, strikethrough = true },
    ["@text.strong"]           = { fg = p.variable, bold = true },
    ["@text.title"]            = { fg = p.type, bold = true },
    ["@text.underline"]        = { fg = p.keyword, underline = true },
    ["@text.uri"]              = { fg = p.type, underline = true },
    ["@text.warning"]          = { fg = p.border, bg = p.error },
    ["@type"]                  = { fg = p.type },
    ["@type.builtin"]          = { fg = p.type },
    ["@variable"]              = { fg = p.variable, style = options.styles.variables },
    ["@variable.builtin"]      = { fg = p.tag },

    -- LSP semantic tokens
    -- ["@lsp.type.comment"] = { link = "@comment" },
    -- ["@lsp.type.enum"] = { link = "@type" },
    -- ["@lsp.type.interface"] = { link = "Identifier" },
    -- ["@lsp.type.keyword"] = { link = "@keyword" },
    -- ["@lsp.type.namespace"] = { link = "@namespace" },
    -- ["@lsp.type.parameter"] = { link = "@parameter" },
    -- ["@lsp.type.property"] = { link = "@property" },
    -- ["@lsp.type.variable"] = {}, -- use treesitter styles for regular variables
    -- ["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" },
    -- ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
    -- ["@lsp.typemod.operator.injected"] = { link = "@operator" },
    -- ["@lsp.typemod.string.injected"] = { link = "@string" },
    -- ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
    -- ["@lsp.typemod.variable.injected"] = { link = "@variable" },

    -- alpha.nvim: https://github.com/goolord/alpha-nvim
    AlphaHeader                = { fg = p.string },
    AlphaButton                = { fg = p.tag },
    AlphaButtons               = { fg = p.tag },
    AlphaFooter                = { fg = p.type },
    AlphaShortcut              = { fg = p.error },

    -- dashboard.nvim: https://github.com/nvimdev/dashboard-nvim
    DashboardHeader            = { fg = p.string },
    DashboardCenter            = { fg = p.tag },
    DashboardFooter            = { fg = p.type },
    DashboardShortcut          = { fg = p.error },

    -- telescope.nvim: https://github.com/nvim-telescope/telescope.nvim
    TelescopeMatching          = { fg = p.string },
    TelescopeSelection         = { fg = p.string, bg = p.bg },
    TelescopeMultiSelection    = { bg = p.bg_panel },
    TelescopePromptTitle       = { fg = p.background, bg = p.keyword },
    TelescopePreviewLine       = { bg = p.light_bg },
    TelescopePromptPrefix      = { fg = p.string, bg = p.cursorline },
    TelescopePromptBorder      = { fg = p.cursorline, bg = p.cursorline },
    TelescopePromptNormal      = { fg = p.fg, bg = p.cursorline },
    TelescopeResultsTitle      = { fg = p.bg_panel, bg = p.bg_panel },
    TelescopeResultsBorder     = { fg = p.bg_panel, bg = p.bg_panel },
    TelescopeResultsNormal     = { fg = p.foreground, bg = p.bg_panel },
    TelescopePreviewTitle      = { fg = p.background, bg = p.type },
    TelescopePreviewBorder     = { fg = p.bg_panel, bg = p.bg_panel },
    TelescopePreviewNormal     = { fg = p.foreground, bg = p.bg_panel },

    -- mason.nvim: https://github.com/williamboman/mason.nvim
    MasonHeader                = { bg = p.namespace, fg = p.black },
    MasonHighlight             = { fg = p.method },
    MasonHighlightBlock        = { fg = p.black, bg = p.match },
    MasonHighlightBlockBold    = { link = "MasonHighlightBlock" },
    MasonHeaderSecondary       = { link = "MasonHighlightBlock" },
    MasonMuted                 = { fg = p.variable },
    MasonMutedBlock            = { fg = p.variable, bg = p.overlay },

    -- mini
    MiniStarterFooter          = { fg = "#FB4934" },

    -- trouble.nvim: https://github.com/folke/trouble.nvim
    LspTroubleCount            = { fg = p.func, bg = p.foreground },
    LspTroubleNormal           = { fg = p.foreground, bg = p.background },
    LspTroubleText             = { fg = p.foreground },

    -- vim-gitgutter: https://github.com/airblade/vim-gitgutter
    GitGutterAdd               = { fg = p.tag },
    GitGutterChange            = { fg = p.keyword },
    GitGutterDelete            = { fg = p.error },

    -- nvim-ufo: https://github.com/kevinhwang91/nvim-ufo
    UfoFoldedBg                = { bg = p.cursorline },

    -- nvim-navic: https://github.com/SmiteshP/nvim-navic
    NavicIconsFile             = { link = "Tag" },
    NavicIconsModule           = { link = "Exception" },
    NavicIconsNamespace        = { link = "Include" },
    NavicIconsPackage          = { link = "Label" },
    NavicIconsClass            = { link = "Include" },
    NavicIconsMethod           = { link = "Function" },
    NavicIconsProperty         = { link = "@property" },
    NavicIconsField            = { link = "@field" },
    NavicIconsConstructor      = { link = "@constructor" },
    NavicIconsEnum             = { link = "@number" },
    NavicIconsInterface        = { link = "Type" },
    NavicIconsFunction         = { link = "Function" },
    NavicIconsVariable         = { link = "@variable" },
    NavicIconsConstant         = { link = "Constant" },
    NavicIconsString           = { link = "String" },
    NavicIconsNumber           = { link = "Number" },
    NavicIconsBoolean          = { link = "Boolean" },
    NavicIconsArray            = { link = "Type" },
    NavicIconsObject           = { link = "Type" },
    NavicIconsKey              = { link = "Constant" },
    NavicIconsNull             = { link = "Constant" },
    NavicIconsEnumMember       = { link = "Number" },
    NavicIconsStruct           = { link = "Type" },
    NavicIconsEvent            = { link = "Constant" },
    NavicIconsOperator         = { link = "Operator" },
    NavicIconsTypeParameter    = { link = "Type" },
    NavicText                  = { link = "SagaText" },
    NavicSeparator             = { link = "Operator" },

    -- nvim-notify: https://github.com/rcarriga/nvim-notify
    NotifyBackground           = { bg = "#141B1E" },
  }

  theme.terminal_colors = {
    terminal_color_0 = p.border,
    terminal_color_1 = p.error,
    terminal_color_2 = p.string,
    terminal_color_3 = p.type,
    terminal_color_4 = p.tag,
    terminal_color_5 = p.keyword,
    terminal_color_6 = p.func,
    terminal_color_7 = p.variable,
    terminal_color_8 = p.overlay,
    terminal_color_9 = p.namespace,
    terminal_color_10 = p.match,
    terminal_color_11 = p.term_yellow,
    terminal_color_12 = p.method,
    terminal_color_13 = p.term_purple,
    terminal_color_14 = p.builtin,
    terminal_color_15 = p.fg_bright,
  }

  for option, value in pairs(theme.terminal_colors) do
    vim.g[option] = value
  end

  theme.highlights = vim.tbl_extend("force", {}, theme.highlights, options.highlights)

  -- Hide all semantic highlights
  for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
    vim.api.nvim_set_hl(0, group, {})
  end

  -- Set the highlights
  for group, colors in pairs(theme.highlights) do
    if colors.style then
      if type(colors.style) == "table" then
        colors = vim.tbl_extend("force", colors, colors.style)
      end
      colors.style = nil
    end

    vim.api.nvim_set_hl(0, group, colors)
  end
end

return theme
