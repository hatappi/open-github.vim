# open-github.vim
open-github.vim displays files opened in (neo)vim in the browser's Github.  

## Prerequirement
- `git`
- latest (neo)vim

## Installation

For [junegunn/vim-plug](https://github.com/junegunn/vim-plug)

```vimrc
Plug 'hatappi/open-github.vim'
```

## Usage

### `OpenGithubFile`

```vim
" Open current file in Github
:OpenGithubFile
" Opens current file with selected lines in Github 
:'<,'>OpenGithubFile
```
