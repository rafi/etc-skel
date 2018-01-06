# Rafael Bodill's /etc/skel

Minimal configuration for **remote servers**.

Supported programs:

* _**[ag]**_ - common ignore patterns
* _**[bash], [npm], [gem]**_ - aliases, exports, completion, colors, inputrc, install paths
* _**[git]**_ - aliases, advanced settings, common ignore patterns
* _**[mysql], [psql]**_ - aliases, nicer prompt, comfort settings
* _**[ranger]**_ - mostly default configuration
* _**[tmux]**_ - advanced setup
* _**[vim/neovim]**_ - advanced setup

## Origins

These configurations were extracted from [rafi/.config] and [rafi/vim-config].
Visit these repositories for the original full configuration.

## Install

You will need to extract contents of repository into your `~/` directory,
and/or the `/etc/skel` directory which contains files and directories that
are automatically copied over to a new user's home directory when such user
is created by the `useradd` program.

### Local Install

:warning: This will overwrite existing files.

Follow these instructions if you want to install on a local machine.

Specific user:

```sh
cd ~
curl -L https://github.com/rafi/etc-skel/archive/master.tar.gz \
  | tar xzv --strip-components=1 --exclude README.md
```

Copy to `/etc/skel`:

```sh
curl -L https://github.com/rafi/etc-skel/archive/master.tar.gz \
  | tar xzv -C /etc/skel --strip-components=1 --exclude README.md
```

### Remote Install

:warning: This will overwrite existing files.

Follow these instructions if you want to install onto a remote server:

```sh
git clone git://github.com/rafi/etc-skel.git
cd etc-skel
rsync -cavh --exclude=.git . user@server:./
```

[rafi/.config]: https://github.com/rafi/.config
[rafi/vim-config]: https://github.com/rafi/vim-config
[ag]: ./.agignore
[bash]: ./.config/bash
[npm]: ./.config/npm
[gem]: ./.config/gemrc
[git]: ./.config/git
[mysql]: ./.config/mysql
[psql]: ./.config/psql
[vim/neovim]: ./.config/nvim
[ranger]: ./.config/ranger
[tmux]: ./.config/tmux
