function! s:goyo_enter()
  set spell noci nosi noai nolist noshowmode noshowcmd
  Limelight
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
