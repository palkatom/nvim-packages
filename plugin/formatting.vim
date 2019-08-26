set expandtab tabstop=4 softtabstop=4 shiftwidth=4 shiftround
set autoindent smartindent
augroup format_whitespaces
  autocmd!
  autocmd BufWrite * retab
  autocmd BufWrite * %s/\v\s+$//e
augroup end
