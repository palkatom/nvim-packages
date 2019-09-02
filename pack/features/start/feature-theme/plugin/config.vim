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
let s:SID = setup#get_SID(fnamemodify(expand("<sfile>"), ":~"))
let g:lightline.component_function = {
      \"branch": "<SNR>".s:SID."_lightline_branch",
      \"filename_info": "<SNR>".s:SID."_lightline_filename_info",
      \"session": "<SNR>".s:SID."_lightline_session",
      \"pyenv": "<SNR>".s:SID."_lightline_pyenv",
      \}
let g:lightline.tab_component_function = {
      \}
let g:lightline.active = {}
let g:lightline.active.left = [
      \["mode"],
      \["branch"],
      \["trunc", "filename_info"]
      \]
let g:lightline.active.right = [
      \["session"],
      \[],
      \["pyenv"]
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

call feature_helpers#load_plugins(feature_theme#plugins)

syntax on
set background=dark
colorscheme one
highlight! link Folded FoldColumn
highlight! link VertSplit StatusLineNC
let &fillchars = "vert:\ "
