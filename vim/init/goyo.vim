function! s:goyo_enter()
  set spell noci nosi noai nolist noshowmode noshowcmd
  Limelight
endfunction

function! s:goyo_leave()
  set nospell ci si ai list showmode showcmd
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
