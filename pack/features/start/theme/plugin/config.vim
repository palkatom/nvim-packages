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
  try
    let l:branch_name = feature#git#head()
    if !empty(l:branch_name)
      let l:branch_name = pathshorten(l:branch_name)
      if len(l:branch_name) > 15
        let l:branch_name = l:branch_name[:13]."\u2026"
      endif
      return "\u16a0 ".l:branch_name
    endif
  catch
  endtry
  return ""
endfunction

function! s:lightline_filename_info()
  try
    if feature#terminal#is_term_buffer(0)
      return "term:".feature#terminal#name(0)
    endif
  catch
  endtry
  " Only simple filename for certain filetypes
  let s:simple_filename_filetypes = [
        \"help",
        \]
  if index(s:simple_filename_filetypes, &filetype) >= 0
    return expand("%:t")
  endif
  try
    if feature#git#is_git_buffer()
      return expand("%:t")."@".feature#git#diff_type()
    endif
  catch
  endtry
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
  let l:session_name = ""
  try
    let l:session_name = feature#sessions#name()
  catch
  endtry
  return "$[".l:session_name."]"
endfunction

function! s:lightline_pyenv()
  " TODO pyenv support (optional)
  try
    let l:pyenv_name = feature#programming#pyenv_name()
    if !empty(l:pyenv_name)
      return "<".l:pyenv_name.">"
    endif
  catch
  endtry
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
  try
    if feature#terminal#is_term_buffer(0)
      return ""
    endif
  catch
  endtry
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
  try
    if feature#terminal#is_term_buffer(l:bufnr)
      return "term:".feature#terminal#name(l:bufnr)
    endif
  catch
  endtry
  let l:filename = fnamemodify(bufname(l:bufnr), ":t")
  if empty(l:filename)
    return "[No Name]"
  endif
  return l:filename
endfunction

let s:SID = "<SNR>".commons#get_SID(expand("<sfile>"))."_"
let g:lightline.component_function = {
      \"branch": s:SID."lightline_branch",
      \"filename_info": s:SID."lightline_filename_info",
      \"session": s:SID."lightline_session",
      \"pyenv": s:SID."lightline_pyenv",
      \"file_info": s:SID."lightline_file_info",
      \"location": s:SID."lightline_location",
      \}
let g:lightline.tab_component_function = {
      \"tabinfo": s:SID."lightline_tabinfo",
      \"tabfile": s:SID."lightline_tabfile",
      \}
let g:lightline.active = {}
let g:lightline.active.left = [
      \["mode"],
      \[],
      \["trunc", "filename_info"]
      \]
let g:lightline.active.right = [
      \["branch"],
      \["pyenv", "session"],
      \["filetype"]
      \]
let g:lightline.inactive = {}
let g:lightline.inactive.left = [
      \["trunc", "filename_info"],
      \[]
      \]
let g:lightline.inactive.right = [
      \["branch"],
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

call commons#features#load_plugins(feature#theme#plugins)

syntax on
set background=dark
colorscheme one
highlight! link Folded FoldColumn
highlight! link VertSplit StatusLineNC
let &fillchars = "vert:\ "
highlight! link LightlineMiddle_inactive VertSplit
highlight! link LightlineLeft_inactive_0 VertSplit
highlight! link LightlineRight_inactive_0 VertSplit
