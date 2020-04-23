# Headway Vim / Tmux Guide and Cheat Sheet Reference

Hints, workflow optimizations, and plugins that we use for daily Rails and JS dev with the shared Headway Vim/Tmux setup.

See these links for general Vim and Tmux cheat sheets:
  * http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html
  * https://gist.github.com/MohamedAlaa/2961058
  * https://vim.rtorr.com
  * http://vimcasts.org/episodes/archive/
  * Things you can do with Vim registers:
    - https://stackoverflow.com/a/3997110/935514

## Configuring Karabiner Elements

https://www.youtube.com/watch?v=DN0BDSiuKsY

## Setting Up Projects with Tmuxinator

    rvm @global do gem install tmuxinator

Adding tmuxinator to the global gemset per ruby will allow you to launch projects regardless of their ruby version.

## Navigating Vim/Tmux splits:

Hold `<ctrl>` down and type a movement key: `hjkl` to move left, down, up, or right, respectively. This even works across/between Vim/Tmux splits.

## Remapped Leader Key

The default `<leader>` key in Vim is `\`, but we remap it to `,`. We also have a few commands nested under the `<localleader>` subset and we have `<localleader>` mapped to `\`. Anywhere in the documentation that you see a command referred to by `<leader>KEY_HERE` you should interpret it as `comma KEY_HERE`.

## Running Specs

I recommend having the source file in a left vertical split, the test in a right vertical split, and the tmux pane in a vertical split on the far right. This setup allows you to see the console level output of your test run while easily staying in the context of editing the test file itself.

There are multiple ways to achieve this layout / setup, but the easiest is to launch vim, then open a 33% tmux vertical split by typing `<ctrl-a>T`. From here, open your `user.rb` file, then type `:AV` which will enter Vim's "Command" mode (the colon does that) and execute the command to open the "alternate file" of your current buffer in a new vertical split. This will automatically open the `user_spec.rb` file for you! Then type `<leader>t` anywhere in the spec file to run the whole spec. The right hand tmux split will refresh and your test will be executed. If you want to run a specific test, type `<leader>T` on a line inside a given `context` or `it` block.

## Plugins

### CoC (Language Server Client): [coc.nvim](https://github.com/neoclide/coc.nvim)
CoC brings many IDE features that you see in VS Code to Vim! CoC is a client for servers that implement the language server protocol. This means that IDE features for a language only have to be written once, and any editor with a suitable language server client can consume that server.

Install language-specific extenstions
```markdown
:CocInstall coc-tsserver       Typescript (Also works great for plain JS)
:CocInstall coc-eslint         Enables eslint and prettier support (works in TS and JS)
:CocInstall coc-elixir         Elixir
:CocInstall coc-solargraph     Ruby
```

Key Bindings
```markdown
K               Shows a floating window with information/documentation.
                (Same as mouse hover in VSCode)
<ctrl><space>   While in insert mode, opens the autocompletion suggestion list. Use <tab> and <shift><tab> 
                to select from auto complete list.
gd              Go to definition
gy              Go to type definition
gi              Go to implementation
gr              Find references
,rn             Rename symbol (works across entire project)
,f              Format selected code
<space>o        Search symbols in current buffer
<space>s        Search symbols in entire project
<space>a        List project wide diagnostics
[g              Navigate to next diagnositic
]g              Navigate to prev diagnositic
<space>e        List extensions
<space>c        List commands
```

More keybindings are available checkout out the README for [coc.nvim](https://github.com/neoclide/coc.nvim) to learn them all!

### Fuzzy Finder: [fzf](https://github.com/junegunn/fzf.vim)
```markdown
<ctrl-f>
```
This brings up a list of files that you can "fuzzy search" through. So if you want to open the `users_controller.rb` you can type `<ctrl-f>` and then `usercont` or possibly `ucont` or `usertroller`. If a given entry isn't coming up for you, prefix it with the folder structure as is often necessary when pulling up the `user.rb` model.


### Project-Wide Search: [Ack/Ag](https://github.com/mileszs/ack.vim)

    <leader><ctrl-f>

[Ag](https://github.com/ggreer/the_silver_searcher) (aka the silver searcher) greatly improves the speed of project-wide search. Ag is a replacement for Ack, which is a replacement for Grep. But most people still call it "grepping" or ask "can you grep for that method?".

Once you have a result set populated in the "Quickfix" you can navigate forward and backward by typing `]q` to go forward or `[q` to go backwards.

Note: You must have `ag` installed via Brew for the searching to work. `brew install ag`


### NERDTree

NERDTree is our "project drawer" and it's setup to sync across all open tabs (which is really nice for keeping context). You can navigate NERDTree just like any other Vim split (because it is one) with h,j,k,l. Type `o` to open the current directory, and type `gi` to preview the file under your cursor while keeping NERDTree in focus. This is helpful if you're looking for something but don't remember what file it's in or what to grep for. Another handy tip is to "reveal the current file in the tree" you can type `<leader>D`. I'll do this frequently if I am on a `users/show.html.slim` view, but want to edit the `users/edit.html.slim` view. It's faster to type `<leader>D` then navigate up or down one or two files, and press `s` to open the file in a vertical split. Typing `i` on a file in the NERDTree will open it in a horizontal split. You can see many more shortcuts by typing `?` anywhere in NERDTree which brings up their built-in help. Take some time to look around! Just because we're in Vim doesn't mean we have to abandon traditional IDE project drawers!

```markdown
o            Open the current directory
gi           Preview the current file but keep cursor on NERDTree
I            Show hidden files in NERD tree
R/r          Reload NERD tree root / current node
,D           Sync NERD tree to current file
,d           Show/hide NERD tree
t            Open file in new tab
s            Open file in new vertical split
i            Open file horizontal split
m            Open file operation menu on the current node (to move/rename/delete)
```

## More Command Details

### General Vim
```markdown
<ctrl-N>     Autocomplete
<ctrl-^>     Open most recent file in jump list
p <ctrl-p>   Paste then cycle through clipboard history
,b           Open buffer list in buffergator
,[space]     Clear highlights
*            Search for word under cursor
,cl          Comment selected lines
,ci          Uncomment selected lines
gq           Wrap selected text with hard returns
,ev          Edit vim config in new tab
J            Join two lines
<ctrl-]>     Jump to ctag definition
```

### Rails.vim
```markdown
:A           Open alternate file
:AV          Open alternate file in vertical split
gf           Go to the file under the cursor. Works to go to gems, too.
```

### Split manipulation
```markdown
<ctrl-w>R    Swap top/bottom or left/right split
<ctrl-w>o    Zoom current split. Repeat to unzoom
,-           Open new horizontal split
,|           Open new vertical split
```

### Search and replace
```markdown
viw          Visually select in word. Then <ctrl-n> or <ctrl-x> to select more or fewer matchds
             after which you can perform an action like d to delete them all, or c to change them all with multiple cursors
,s           Start local buffer search and replace for the word under the cursor
%s/f/r/gc    [f]ind and [r]eplace in buffer with [c]onfirm, [g]lobally
,<ctrl-f>    Start global search.
<ctrl-r>w    Pastes the word under the cursor to the Vim command mode line. Hold <ctrl> down and press r, release r, then press w
```

### Fuzzy Finder
```markdown
<ctrl-f>     Open fuzzy finder
<ctrl-t>     From fuzzy finder - open file in new tab
<ctrl-i>     From fuzzy finder - open file in new split
```

### Quickfix
```markdown
,cq          Close quickfix window
,co          Open quickfix window
]q           Next quickfix item
[q           Previous quickfix item
```

### Vim Diff
```markdown
do           Diffget + diffupdate
dp           Diffput + diffupdate
:dif         Refresh dif window
]c           Next change
[c           Previous change
```

### Vim Fugative / Git
```markdown
,gd          :Gdiff<cr>
,gst         :Gstatus<cr>
,gw          :Gwrite<cr>
,ge          :Gedit<cr>
,gb          :Gblame -w -M<cr>
,gB          :Gitv!<cr>
,gco         :Gread<cr>
,gcm         :Gcommit<cr> (or press C in the status window)
,glg         :Glog<cr>
```

### Tmux Cheat Sheet
- http://tmuxp.readthedocs.io/en/latest/about_tmux.html
- http://alvinalexander.com/linux-unix/tmux-cheat-sheet-commands-pdf

**Note:** All commands start with `<ctrl-a>`

```markdown
d            detach tmux session
T            open new vertical split
t            open new horizontal split
N            open new window
[number]     jump to n window
n            jump to next window
R            reload config
[up arrow]   zoom current tmux split. Repeat to unzoom.
x            kill process and close current pane
{ or }       move tmux pane left or right
< or >       move tmux window left or right
[            enter VIM mode which allows scrolling and searching with “/"
```
