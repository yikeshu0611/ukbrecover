.sv_restore_x = system('dx ls -l .Backups',intern = T)
(.sv_restore_x <- .sv_restore_x[grepl('tar.gz \\(file-',.sv_restore_x,T)])
(.sv_restore_x <- .sv_restore_x[grepl('closed ',.sv_restore_x)])
if (length(.sv_restore_x)==0) stop('没有可以恢复的数据')
.sv_restore_timep = '[0-9]{4}-[0-9]{1,2}-[0-9]{1,2} {0,}[0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}'
.sv_restore_wh = grep(.sv_restore_timep,.sv_restore_x)
(.sv_restore_x1 = .sv_restore_x[.sv_restore_wh])
(.sv_restore_x2 = gsub('.tar.gz \\(file-.*','',.sv_restore_x1))
.sv_restore_x2 = sub(' ','jjjjjjiiii',.sv_restore_x2)
(.sv_restore_x3=sub('.*jjjjjjiiii {0,}','',.sv_restore_x2))
(.sv_restore_x4 = sub(' {1,}','jjjjjjiiii',.sv_restore_x3))
(.sv_restore_x4=sub(' .*','',.sv_restore_x4))
(.sv_restore_x4=sub('jjjjjjiiii',' ',.sv_restore_x4))
(.sv_restore_wh = which.max(as.POSIXct(.sv_restore_x4)))
(.sv_restore_x3 = gsub('.*\\(','',.sv_restore_x1[.sv_restore_wh]))
(.sv_restore_x3=gsub('\\)','',.sv_restore_x3))
.x=system(paste0("dx-restore-folder ",.sv_restore_x3,' 2>/dev/null'),T)
if (gsub(' to \\.','',gsub('Restoring ','',.x)) == .sv_restore_x3){
  message('OK')
}else{
  message('ERROR')
}
