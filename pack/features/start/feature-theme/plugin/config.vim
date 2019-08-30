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
  if exists("*Terminal_IsTermBuffer()") && exists("*Terminal_Name()")
    if Terminal_IsTermBuffer(0)
      return "term:".Terminal_Name(0)
    endif
  endif
  " TODO
  let l:short_dir = pathshorten(expand("%:p:h"))
  let l:filename = expand("%:t")
  if empty(l:filename)
    let l:filename = "[No Name]"
    let l:short_dir = ""
  endif
  let l:filepath = expand(l:short_dir."/".l:filename)
  let l:modified_flag = !&modifiable ? "[-]" :
        \&modified ? "[+]" : ""
  let l:readonly_flag = &readonly ? "[RO]" : ""
  return l:filepath.l:readonly_flag.l:modified_flag
endfunction
let s:SID = setup#get_SID(expand("%:~"))
let g:lightline.component_function = {
      \"branch": "<SNR>".s:SID."_lightline_branch",
      \"filename_info": "<SNR>".s:SID."_lightline_filename_info",
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
      \[],
      \[],
      \[]
      \]

call feature_helpers#load_plugins(feature_theme#plugins)

syntax on
set background=dark
colorscheme one
highlight! link Folded FoldColumn
highlight! link VertSplit StatusLineNC
let &fillchars = "vert:\ "
