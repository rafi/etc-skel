# Vim config

This is my Vim configuration, crafted with love and care. It contains useful plugins and
a few colorschemes, awesome configurations and keybindings.

## Install

1. Ensure your XDG environment variables are set.
  If not, add this to your `.bashrc` or `.[bash_]profile`:
  ```sh
  # XDG directories
  export XDG_CONFIG_HOME="$HOME/.config"
  export  XDG_CACHE_HOME="$HOME/.cache"
  export   XDG_DATA_HOME="$HOME/.local/share"
  ```

2. Create cache folders:
  ```sh
  mkdir -p $XDG_CACHE_HOME/vim/{backup,swap,undo}
  ```

3. Build [vimproc]. Read [vimproc]'s manual. Usually `make` is enough:
  ```sh
  cd ~/.vim
  make
  ```

## Included Plugins

Name           | Description
-------------- | ----------------------
[ansible-yaml] | Additional support for Ansible
[bookmarks] | Bookmarks, works independently from vim marks
[css3-syntax] | CSS3 syntax support to vim's built-in `syntax/css.vim`
[csv] | Handling column separated data
[file-line] | Allow opening a file in a given line
[fugitive] | Git wrapper
[hybrid] | Dark colour scheme
[javascript] | Vastly improved Javascript indentation and syntax support
[json] | Better JSON support
[less] | Syntax for LESS
[lightline] | Light and configurable statusline/tabline
[markdown] | Markdown syntax highlighting
[mustache] | Mustache and handlebars mode
[nerdcommenter] | Intense commenting
[signify] | Show a VCS diff using the sign column
[surround] | Quoting/parenthesizing made simple
[syntastic] | Syntax checking hacks
[tabular] | Text filtering and alignment
[tagbar] | Displays tags in a window, ordered by scope
[tmux-navigator] | Seamless navigation between tmux panes and vim splits
[unite] | Unite and create user interfaces
[unite-neomru] | MRU source for Unite
[unite-outline] | File "outline" source for unite
[unite-tag] | Tags source for Unite
[vimfiler] | Powerful file explorer
[vimproc] | Interactive command execution
[visual-star-search] | Start a * or # search from a visual block

[ansible-yaml]: https://github.com/chase/vim-ansible-yaml
[bookmarks]: https://github.com/MattesGroeger/vim-bookmarks
[css3-syntax]: https://github.com/hail2u/vim-css3-syntax
[csv]: https://github.com/chrisbra/csv.vim
[file-line]: https://github.com/bogado/file-line
[fugitive]: https://github.com/tpope/vim-fugitive
[hybrid]: https://github.com/w0ng/vim-hybrid
[javascript]: https://github.com/pangloss/vim-javascript
[json]: https://github.com/elzr/vim-json
[less]: https://github.com/groenewege/vim-less
[lightline]: https://github.com/itchyny/lightline.vim
[markdown]: https://github.com/plasticboy/vim-markdown
[mustache]: https://github.com/mustache/vim-mustache-handlebars
[nerdcommenter]: https://github.com/scrooloose/nerdcommenter
[signify]: https://github.com/mhinz/vim-signify
[surround]: https://github.com/tpope/vim-surround
[syntastic]: https://github.com/scrooloose/syntastic
[tabular]: https://github.com/godlygeek/tabular
[tagbar]: https://github.com/majutsushi/tagbar
[tmux-navigator]: https://github.com/christoomey/vim-tmux-navigator
[unite]: https://github.com/Shougo/unite.vim
[unite-neomru]: https://github.com/Shougo/neomru.vim
[unite-outline]: https://github.com/h1mesuke/unite-outline
[unite-tag]: https://github.com/tsukkee/unite-tag
[vimfiler]: https://github.com/Shougo/vimfiler.vim
[vimproc]: https://github.com/Shougo/vimproc.vim
[visual-star-search]: https://github.com/nelstrom/vim-visual-star-search
