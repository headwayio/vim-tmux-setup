""" INITIALIZE PLUGIN SYSTEM START
call plug#begin('~/.vim/plugged')

Plug 'ciaranm/securemodelines'                       " Secure the modelines, apparently. https://linux.slashdot.org/story/19/06/15/0314215/vim-and-neo-editors-vulnerable-to-high-severity-bug

""" IDE CAPABILITIES
Plug 'LStinson/TagmaTasks'                           " Show project wide list of TODO, NOTE, FIXME
Plug 'coderifous/textobj-word-column.vim'            " Better vertical column selection / changing (vic will visual in column)
Plug 'jeetsukumaran/vim-buffergator'                 " Easily switch between buffers
Plug 'majutsushi/tagbar'                             " Drawer showing ctags
Plug 'sjl/gundo.vim'                                 " Undo tree history navigation
Plug 'tell-k/vim-browsereload-mac'                   " Browser Reloading from Vim
Plug 'Shougo/vimproc.vim'                            " Dependency of vim-browserreload-mac
Plug 'tpope/vim-projectionist'                       " Define alternate files
Plug 'vim-scripts/YankRing.vim'                      " Cycle through yanks/deletes in a visual window or after pasting

"""" COC Config
" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Should be possible to install extensions using Plug with a later version of
" CoC
" Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}

"""" TAB COMPLETION LIKE TEXTMATE FOR SNIPPETS
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

""""" LANGUAGE SPECIFIC SNIPPETS
Plug 'tellijo/vim-react-native-snippets'
Plug 'mlaursen/vim-react-snippets'


"""" PROJECT DRAWER
Plug 'Xuyuanp/nerdtree-git-plugin'                   " Show changed files in NERDTree
Plug 'jistr/vim-nerdtree-tabs'                       " Makes NERDTree awesome if you use tabs
Plug 'scrooloose/nerdtree'                           " Project drawer

""" GIT
Plug 'airblade/vim-gitgutter'                        " Show diff in the left gutter
Plug 'gregsexton/gitv'                               " Tig inside of vim with more power to traverse file history
Plug 'mattn/gist-vim'                                " Gist things
Plug 'mattn/webapi-vim'                              " Dependency of gist-vim
Plug 'tpope/vim-fugitive'                            " Git wrapper
Plug 'tpope/vim-git'                                 " Some vim runtime files that are more up to date than those distributed with vim itself
Plug 'tpope/vim-rhubarb'                             " GitHub extension for fugitive.vim

""" BUFFER NAVIGATION / TEXT MANIPULATION
Plug 'Lokaltog/vim-easymotion'                       " <leader><leader>w jump to highlighted word
Plug 'christoomey/vim-tmux-navigator'                " Navigate with C-h/j/k/l in tmux and vim
Plug 'godlygeek/tabular'                             " Align code
Plug 'gorkunov/smartpairs.vim'                       " Smart selection between pairs (viv)
Plug 'itspriddle/vim-stripper'                       " Strip trailing whitespace on save
Plug 'justincampbell/vim-eighties'                   " Ensures windows are at least 80 chars wide (my PR added the ability to ignore a list of additional bufnames)
Plug 'scrooloose/nerdcommenter'                      " Comment multiple lines
Plug 'tpope/vim-ragtag'                              " Some nice text wrappers for editing erb or html, ctrl+x in insert mode then type = or - or @ or #,etc
Plug 'tpope/vim-repeat'                              " Repeat surround (and other) changes with .
Plug 'tpope/vim-surround'                            " Easily change what something is surrounded by
Plug 'tpope/vim-unimpaired'                          " Allows for moving blocks of text up and down in place like you could in textmate
Plug 'vim-scripts/ZoomWin'                           " Lets you ctrl+w+o to toggle out a split to it's own buffer (easily can go back with the same command)
Plug 'alvan/vim-closetag'                            " Automatically close an html tag when you type the opening of it

""" THEME / PRESENTATION
Plug 'bfontaine/Brewfile.vim'                          " Brewfile syntax
Plug 'edkolev/tmuxline.vim'
Plug 'lifepillar/vim-solarized8'                     " The best possible color scheme ever
Plug 'mustache/vim-mustache-handlebars'              " Handlebars templates
Plug 'nathanaelkane/vim-indent-guides'               " Show indent guides to the left of the methods
Plug 'terryma/vim-multiple-cursors'                  " like sublime multiple cursors
Plug 'tmux-plugins/vim-tmux'                         " Tmux config syntax hilighting
Plug 'tpope/vim-bundler'                             " Highlights Gemfile and wraps bundle open
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-dotenv'                              " .env file editing in vim (syntax highlighting, mostly)

""" LANAUAGE SPECIFIC
"""" RUBY
Plug 'vim-ruby/vim-ruby'
Plug 'bruno-/vim-ruby-fold'                          " Auto-fold files upon open. Disable session-wide with: <leader>nf
Plug 'ecomba/vim-ruby-refactoring'                   " refactor model names
Plug 'tpope/vim-abolish'                             " Dependency of vim-ruby-refactoring
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'tpope/vim-rails'
Plug 'KurtPreston/vim-autoformat-rails'
Plug 'thoughtbot/vim-rspec'                          " thoughtbot vim-rspec send to tmux, vim-dispatch, etc
Plug 'onemanstartup/vim-slim'                        " Slim template syntax highlighting
Plug 'tpope/vim-haml'                                " Enabled .haml extension
Plug 'jondkinney/vim-cucumber'                       " Enabled .feature files

"""" YAML
Plug 'avakhov/vim-yaml'                              " Yaml stuff

"""" JAVASCRIPT
""""" BASE
" Plug 'othree/yajs.vim'
" Plug 'othree/javascript-libraries-syntax.vim'
" Plug 'othree/es.next.syntax.vim'
" Plug 'gavocanov/vim-js-indent'
" Plug 'isRuslan/vim-es6'                              " es-6 help
" Plug 'pangloss/vim-javascript'

"""" TYPESCRIPT
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'                                   " TSX syntax highlighting

""""" FLAVORS
Plug 'kchmck/vim-coffee-script'                      " enable coffeescript
Plug 'glanotte/vim-jasmine'

""""" REACT
Plug 'MaxMEllon/vim-jsx-pretty'                      " Better than: Plug 'mxw/vim-jsx'
Plug 'psychollama/further.vim'                     " Follow JavaScript imports to their source


"""" ELIXIR
Plug 'elixir-editors/vim-elixir'
Plug 'slime-lang/vim-slime-syntax'


""" SEARCH
Plug 'henrik/vim-indexed-search'                     " Gives a count of the number of matches, configured to stay on current match with indexed_search_dont_move=1
Plug 'nelstrom/vim-visual-star-search'               " Don't jump to the next search, stay on current one
Plug 'haya14busa/incsearch.vim'                      " better incremental search, highlights in realtime everywhere as you type
Plug 'henrik/vim-qargs'                              " Project wide find and replace http://thepugautomatic.com/2012/07/project-wide-search-and-replace-in-vim-with-qdo/
Plug 'junegunn/fzf',
      \ { 'dir': '~/.fzf', 'do': './install --all' } " Fuzzy Find
Plug 'mileszs/ack.vim'                               " project wide search
Plug 'yssl/QFEnter'                                  " open splits from quickfix

""" WRITING PROSE
Plug 'itspriddle/vim-marked'
Plug 'kana/vim-textobj-user'
Plug 'plasticboy/vim-markdown'
Plug 'reedes/vim-lexical'
Plug 'reedes/vim-litecorrect'
Plug 'reedes/vim-pencil'
Plug 'reedes/vim-textobj-quote'
Plug 'reedes/vim-textobj-sentence'
Plug 'suan/vim-instant-markdown'

"""" SPELLING
Plug 'jonhiggs/MacDict.vim'

""" WIKI
Plug 'vimwiki/vimwiki'
Plug 'mattn/calendar-vim'

""" TESTING
Plug 'benmills/vimux'                                " Send to tmux pane
Plug 'jgdavey/vim-turbux'                            " Send to tmux pane
Plug 'janko-m/vim-test'                              " Test runner
Plug 'jondkinney/rspec.vim'                          " RSpec syntax highlighting improvements
Plug 'killphi/vim-legend'                            " Parses and displays x or check in the gutter for covered lines through cadre.
Plug 'wfleming/vim-codeclimate'

""" DASH DOCS
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    " Do Mac stuff here
    Plug 'rizzatti/funcoo.vim'
    Plug 'rizzatti/dash.vim'
  endif
endif


""" DEPRECATED
Plug 'chrisbra/csv.vim'
Plug 'tpope/vim-rake'
Plug 'tmux-plugins/vim-tmux-focus-events'            " Regain focus events for terminal vim

""" INITIALIZE PLUGIN SYSTEM END
call plug#end()

""" Vim Plug automatically manage plugin installation and cleaning on load
let s:need_install = keys(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
let s:need_clean = len(s:need_install) + len(globpath(g:plug_home, '*', 0, 1)) > len(filter(values(g:plugs), 'stridx(v:val.dir, g:plug_home) == 0'))
let s:need_install = join(s:need_install, ' ')
if has('vim_starting')
  if s:need_clean
    autocmd VimEnter * PlugClean!
  endif
  if len(s:need_install)
    execute 'autocmd VimEnter * PlugInstall --sync' s:need_install '| source $MYVIMRC'
    finish
  endif
else
  if s:need_clean
    PlugClean!
  endif
  if len(s:need_install)
    execute 'PlugInstall --sync' s:need_install '| source $MYVIMRC'
    finish
  endif
endif""

"" vim:fdm=expr:fdl=0
"" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
