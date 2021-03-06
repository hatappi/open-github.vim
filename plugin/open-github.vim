function! s:get_repo_url()
  let url = system('git config --get remote.origin.url')

  let m = matchlist(url, '\vhttps?://github.com/([^/]+)/([^/]+)')
  if len(m) == 0
    let m = matchlist(url, '\vgit\@github.com:([^/]+)/(.+)')
  endif

  if len(m) == 0
    return
  endif

  let org = trim(m[1])
  let repo = substitute(trim(m[2]), '\v.git$', "", "g")

  return "https://github.com/" . org . "/" . repo . "/"
endfunction

function! s:get_target_filepath()
  let root_dir = system("git rev-parse --show-toplevel | tr -d '\\n'")
  let relative_path = expand("%:p")
  if relative_path =~ '\v' . root_dir
    return substitute(relative_path, '\v' . root_dir . "/?", "", "g")
  else
    redraw
    echohl WarningMsg
    echo "It doesn't support open url. plese open following URL yourself."
    echohl None
    echo relative_path
  endif
endfunction

function! s:get_commit_hash()
  let commit_hash = system('git rev-parse HEAD')

  return trim(commit_hash)
endfunction

function! s:open_github_url(url)
  if has('mac')
    call system("open " . a:url)
  else
    redraw
    echohl WarningMsg
    echo "It doesn't support open url. plese open following URL yourself."
    echohl None
    echo a:url
  endif
endfunction

function! OpenGithubFile(start_line, end_line)
  let repo_url = s:get_repo_url()
  let filepath = s:get_target_filepath()
  if filepath == ""
    return
  endif
  let commit_hash = s:get_commit_hash()

  let open_url = repo_url . "blob/" . commit_hash . "/" . filepath . "#L" . a:start_line . "-L" . a:end_line

  return s:open_github_url(open_url)
endfunction

command! -range OpenGithubFile :call OpenGithubFile(<line1>, <line2>)

