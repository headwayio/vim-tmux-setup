" this is the configuration file for linux and mac systems
" symlink this to your home folder as .vimrc
" It loads ~/.vim/vundle and loads all modules from ~/.vim/bundle.
" It then loads ~/.vim/vimrc_main which has the main
" configuration that works across all systems.
if has('nvim')
  runtime! python_setup.vim
endif

source ~/.vim/plugins.vim
source ~/.vim/vimrc_main
source ~/.vimrc_custom

" Put platform specific stuff here.
