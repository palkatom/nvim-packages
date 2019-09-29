let g:one_allow_italics = 1
set termguicolors

set noshowmode
let g:lightline = {}
let g:lightline.colorscheme = "one"
let g:lightline.component = {
      \"trunc": "%<",
      \}
let g:lightline.component_visible_condition = {
      \"trunc": 0,
      \}
let g:lightline.component_type = {
      \"trunc": "raw",
      \}

function! s:lightline_branch()
  if exists("*Git_Head()")
    let l:branch_name = Git_Head()
    if !empty(l:branch_name)
      let l:branch_name = pathshorten(l:branch_name)
      if len(l:branch_name) > 15
        let l:branch_name = l:branch_name[:13]."\u2026"
      endif
      return "\u16a0 ".l:branch_name
    endif
  endif
  return ""
endfunction

function! s:lightline_filename_info()
  " TODO Terminal functions
  if exists("*Terminal_IsTermBuffer()") && exists("*Terminal_Name()")
    if Terminal_IsTermBuffer(0)
      return "term:".Terminal_Name(0)
    endif
  endif
  " Only simple filename for certain filetypes
  let s:simple_filename_filetypes = [
        \"help",
        \]
  if index(s:simple_filename_filetypes, &filetype) >= 0
    return expand("%:t")
  endif
  " TODO Git functions
  if exists("*Git_IsGitBuffer()") && exists("*Git_DiffType()")
    if Git_IsGitBuffer()
      return expand("%:t")."@".Git_DiffType()
    endif
  endif
  let l:short_dir = pathshorten(expand("%:p:h"))."/"
  let l:filename = expand("%:t")
  if empty(l:filename)
    let l:filename = "[No Name]"
    let l:short_dir = ""
  endif
  let l:filepath = expand(l:short_dir.l:filename)
  let l:modified_flag = !&modifiable ? "[-]" :
        \&modified ? "[+]" : ""
  let l:readonly_flag = &readonly ? "[RO]" : ""
  return l:filepath.l:readonly_flag.l:modified_flag
endfunction

function! s:lightline_session()
  " TODO Sessions functions
  if exists("*Sessions_Name()")
    let l:session_name = Sessions_Name()
  else
    let l:session_name = ""
  endif
  return "$[".l:session_name."]"
endfunction

function! s:lightline_pyenv()
  " TODO pyenv support (optional)
  if exists("*Programming_PyenvName()")
    let l:pyenv_name = Programming_PyenvName()
    if !empty(l:pyenv_name)
      return "<".l:pyenv_name.">"
    endif
  endif
  return ""
endfunction

function! s:lightline_file_info()
  let l:filetype = "[".&filetype."]"
  " Do not add other information for certain filetypes
  let l:simple_filetypes = [
        \"help",
        \]
  if index(l:simple_filetypes, &filetype) >= 0
    return l:filetype
  endif
  if exists("*Terminal_IsTermBuffer()")
    if Terminal_IsTermBuffer(0)
      return ""
    endif
  endif
  if winwidth(0) < 90
    return ""
  endif
  let l:fileformat = &fileformat ==? "dos" ? "CRLF" : "LF"
  let l:fileencoding = &fileencoding
  return l:filetype.l:fileformat."/".l:fileencoding
endfunction

function! s:lightline_location()
  if winwidth(0) < 75
    return ""
  endif
  let l:line = line(".")
  let l:column = col(".")
  let l:percentage = float2nr(round(100.0*l:line/line("$")))
  return printf("%4d:%03d|%3d%%", l:line, l:column, l:percentage)
endfunction

function! s:lightline_tabinfo(tabnum)
  return "[".a:tabnum."](".tabpagewinnr(a:tabnum, "$").")"
endfunction

function! s:lightline_tabfile(tabnum)
  let l:winnr = tabpagewinnr(a:tabnum)
  let l:bufnr = tabpagebuflist(a:tabnum)[l:winnr - 1]
  if exists("*Terminal_IsTermBuffer()") && exists("*Terminal_Name()")
    if Terminal_IsTermBuffer(l:bufnr)
      return "term:".Terminal_Name(l:bufnr)
    endif
  endif
  let l:filename = fnamemodify(bufname(l:bufnr), ":t")
  if empty(l:filename)
    return "[No Name]"
  endif
  return l:filename
endfunction

let s:SID = helpers#get_SID(expand("<sfile>"))
let g:lightline.component_function = {
      \"branch": "<SNR>".s:SID."_lightline_branch",
      \"filename_info": "<SNR>".s:SID."_lightline_filename_info",
      \"session": "<SNR>".s:SID."_lightline_session",
      \"pyenv": "<SNR>".s:SID."_lightline_pyenv",
      \"file_info": "<SNR>".s:SID."_lightline_file_info",
      \"location": "<SNR>".s:SID."_lightline_location",
      \}
let g:lightline.tab_component_function = {
      \"tabinfo": "<SNR>".s:SID."_lightline_tabinfo",
      \"tabfile": "<SNR>".s:SID."_lightline_tabfile",
      \}
let g:lightline.active = {}
let g:lightline.active.left = [
      \["mode"],
      \["branch"],
      \["trunc", "filename_info"]
      \]
let g:lightline.active.right = [
      \["session", "location"],
      \[],
      \["pyenv", "file_info"]
      \]
let g:lightline.inactive = {}
let g:lightline.inactive.left = [
      \["branch", "trunc", "filename_info"],
      \[]
      \]
let g:lightline.inactive.right = [
      \["session"],
      \[]
      \]
let g:lightline.tab = {}
let g:lightline.tab.active = [
      \"tabinfo",
      \"tabfile",
      \"modified",
      \]
let g:lightline.tab.inactive = [
      \"tabinfo",
      \"tabfile",
      \"modified",
      \]

call feature#helpers#load_plugins(feature#theme#plugins)

syntax on
set background=dark
colorscheme one
highlight! link Folded FoldColumn
highlight! link VertSplit StatusLineNC
let &fillchars = "vert:\ "
highlight! link LightlineMiddle_inactive VertSplit
