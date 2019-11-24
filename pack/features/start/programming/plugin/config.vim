try
  let g:test#strategy = feature#terminal#type()
catch
endtry

call commons#features#load_plugins(feature#programming#plugins)

" Register servers
if executable("pyls")
  augroup python_lsp
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \"name": "pyls",
          \"cmd": {server_info->["pyls"]},
          \"whitelist": ["python"],
          \})
  augroup end
endif
if executable("clangd-8")
  augroup cpp_lsp
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \"name": "clangd",
          \"cmd": {server_info->["clangd-8", "-background-index"]},
          \"whitelist": ["cpp", "h"]
          \})
  augroup end
endif
if executable("clojure-lsp")
  augroup clojure_lsp
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \"name": "clojure-lsp",
          \"cmd": {server_info->["clojure-lsp"]},
          \"whitelist": ["clojure"]
          \})
  augroup end
endif
" Enable LSP explicitly as it can be loaded on-demand
call lsp#enable()
