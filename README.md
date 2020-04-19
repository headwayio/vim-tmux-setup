## Console VIM and Tmux setup compatible with Mac OS X and Linux.

### Cheat Sheet

See the included documentation in the cheat_sheet.md file.


### Installation

Install by running the following command in your terminal:

```
exec 3<&1;bash <&3 <(curl https://gist.githubusercontent.com/jondkinney/2040114/raw/vim.sh 2> /dev/null)
```

The bash redirects allow this script to prompt for user input including
preserving an existing `~/.vim` directory by appending "-bak" to any
files/directories that are written, overwriting an existing setup destructively
or skipping any of the configurations individually, or choosing `r` to
keep a `~/.vimrc_main` file sync'd across multiple machines. Here's how it
would look:

```
***** Note: You already have a Vim configuration...
Would you like to (b)ack it up, (o)verwrite it, (r)efresh ~/.vimrc_main, or (s)kip Vim setup (B/o/r/s)?
```
Typing `r` and pressing return then outputs this message:

```
Refreshing ~/.vimrc_main and leaving the rest of your Vim setup untouched.
```

### Prerequisites:

Required:

* `brew install git`
* `brew install neovim`
* `brew install ag`
* `brew install tmux`
* `brew install reattach-to-user-namespace`

Optional:

* `brew install zsh`
* [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh/)
* [iTerm 2](http://www.iterm2.com/#/section/home)

### Customizations To The Defaults

**Tmux:**

* Tmux prefix re-mapped from `ctrl-b` to `ctrl-a`
  * I also recommend [re-mapping your caps lock Key](http://cl.ly/I186) to control.
* Provides an optional [tmuxinator](https://github.com/aziz/tmuxinator/) Rails dev YAML setup file

**Vim:**

* `~/.vimrc` loads:
  * Plugins through vim-plug
  * Sources `~/.vimrc_main` which holds the actual Vim config
  * Allow user customizations through `~/.vimrc_custom`
* `<leader>` re-mapped to `,`
* Navigate between splits with just ctrl + movement (h, j, k, or l)
* Resizing splits vertically with `_/+` and horizontally with `option -/=`
* Save files with SS. If you need to type actual SS, toggle paste in insert mode with F2
