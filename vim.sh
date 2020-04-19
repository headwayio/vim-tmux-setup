# The first few lines check for an existing Vim setup and ask you if you want
# to overwrite it or back it up. I recommend backing any current Vim settings
# up so you can refer to them later if need be.
while getopts dm name
do
  case $name in
    d)defaults='true';;
    *)echo "Invalid arg";;
  esac
done

if [[ -f "$HOME/bin/pbcopy-remote" ]]; then
  has_pbcopy_remote="true"
fi

if [[ -f "$HOME/bin/pbpaste-remote" ]]; then
  has_pbpaste_remote="true"
fi

if [[ -f "$HOME/Library/LaunchAgents/pbcopy.plist" ]]; then
  has_pbcopy_local="true"
fi

if [[ -f "$HOME/Library/LaunchAgents/pbpaste.plist" ]]; then
  has_pbpaste_local="true"
fi

if [[ -d "$HOME/.vim" && ! -L "$HOME/.vim" ]]; then
  has_dot_vim="true"
fi

if [[ -f $HOME/.vimrc ]]; then
  has_dot_vimrc="true"
fi

if [[ -f $HOME/.config/nvim/init.vim ]]; then
  has_nvim_config="true"
fi

if [[ -f $HOME/.vim/vimrc_main ]]; then
  has_vimrc_main="true"
fi

if [[ -f $HOME/.vimrc_custom ]]; then
  has_vimrc_custom="true"
fi

if [[ -f $HOME/.tmux.conf ]]; then
  has_tmux_conf="true"
fi

if [[ -d "$HOME/.tmuxinator" && ! -L "$HOME/.tmuxinator" ]]; then
  has_tmuxinator="true"
fi

function refresh_vimrc_main(){
  curl -s https://gist.githubusercontent.com/jondkinney/2040114/raw/vimrc_main > $HOME/.vim/vimrc_main
  if [ "$defaults" != "true" ]; then
    echo "!!!!! Wrote $HOME/.vim/vimrc_main"
  fi
}

function full_vim_setup(){
  echo "!!!!! Creating the necessary Vim directories..."
  mkdir -p $HOME/.vim/autoload
  mkdir -p $HOME/.vim/backup
  mkdir -p $HOME/.vim/snippets
  mkdir -p $HOME/.vim/sessions
  mkdir -p $HOME/.vim/undo
  mkdir -p $HOME/.config/nvim

  if [ "$defaults" != "true" ]; then
    echo ">>>>> Writing Config Files..."
  fi

  curl -s https://gist.githubusercontent.com/jondkinney/2040114/raw/plugins.vim > $HOME/.vim/plugins.vim
  if [ "$defaults" != "true" ]; then
    echo "!!!!! Wrote $HOME/.vim/plugins.vim"
    echo "!!!!! Installing vim-plug"
  fi
  curl -s https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > $HOME/.vim/autoload/plug.vim


  curl -s https://gist.githubusercontent.com/jondkinney/2040114/raw/vimrc > $HOME/.vimrc
  if [ "$defaults" != "true" ]; then
    echo "!!!!! Wrote $HOME/.vimrc"
  fi

  if [ "$has_vimrc_custom" != "true" ]; then
    curl -s https://gist.githubusercontent.com/jondkinney/2040114/raw/vimrc_custom > $HOME/.vimrc_custom
    if [ "$defaults" != "true" ]; then
      echo "!!!!! Wrote $HOME/.vimrc_custom"
    fi
  fi

  if [ "$has_nvim_config" != "true" ]; then
    curl -s https://gist.githubusercontent.com/jondkinney/2040114/raw/nvim_init > $HOME/.config/nvim/init.vim
    if [ "$defaults" != "true" ]; then
      echo "!!!!! Wrote $HOME/.config/nvim/init.vim"
    fi
  fi

  curl -s https://gist.githubusercontent.com/jondkinney/2040114/raw/snippets > $HOME/.vim/snippets/_.snippets
  if [ "$defaults" != "true" ]; then
    echo "!!!!! Wrote $HOME/.vim/snippets/_.snippets"
  fi

  refresh_vimrc_main
}

function backup_current_vim_setup(){
  echo ">>>>> Backing up Vim setup..."
  echo "!!!!! Appending -bak to the relevant folders and files...."
  # Remove any old backups
  rm -rf $HOME/.vim-bak
  rm -rf $HOME/.vimrc-bak
  # Backup
  mv -fv $HOME/.vim $HOME/.vim-bak
  mv -fv $HOME/.vimrc $HOME/.vimrc-bak
}

if [ "$has_dot_vim" == "true" -o "$has_dot_vimrc" == "true" -o "$has_vimrc_main" == "true" -o "$has_vimrc_custom" == "true" -o "$has_nvim_config" ]; then
  echo "***** Note: You already have a Vim configuration..."

  if [ "$defaults" == "true" ]; then
    backup_current_vim_setup
    full_vim_setup
  else
    read -p  "????? Would you like to (b)ack it up, (o)verwrite it, (r)efresh ~/.vimrc_main, or (s)kip Vim setup (B/o/r/s)?"

    if [[ $REPLY =~ ^[Ss]$ ]]; then
      echo ">>>>> Skipping Vim configuration..."
    elif [[ $REPLY =~ ^[Rr]$ ]]; then
      echo ">>>>> Refreshing $HOME/.vim/vimrc_main and leaving the rest of your Vim setup untouched"
      refresh_vimrc_main
    elif [[ $REPLY =~ ^[Oo]$ ]]; then
      echo "!!!!! Deleting current Vim setup..."
      sudo rm -rf $HOME/.vim
      rm -f $HOME/.vimrc
      rm -f $HOME/.vim/vimrc_main
      rm -f $HOME/.config/nvim/init.vim
      full_vim_setup
    else
      backup_current_vim_setup
      full_vim_setup
    fi
  fi
else
  if [ "$defaults" == "true" ]; then
    full_vim_setup
  else
    read -p  "????? No previous Vim setup detected, proceed with a full Vim configuration (Y/n)?"
    if [[ $REPLY =~ ^[Nn]$ ]]; then
      echo ">>>>> Skipping Vim configuration..."
    else
      full_vim_setup
    fi
  fi
fi

function backup_tmux(){
  echo "!!!!! Backing up Tmux setup. Appending -bak to the relevant files..."
  mv -fv $HOME/.tmux.conf $HOME/.tmux.conf-bak
  mv -fv $HOME/.tmux $HOME/.tmux-bak
}

function setup_tmuxinator(){
    echo "!!!!! Creating the necessary tmuxinator directories..."

    if [ "$has_tmuxinator" == "true" ]; then
      echo "***** note: $HOME/.tmuxinator already exists"
    else
      mkdir -p $HOME/.tmuxinator
    fi

    curl -s https://gist.githubusercontent.com/jondkinney/2040114/raw/hack.yml > $HOME/.tmuxinator/hack.yml
    if [ "$defaults" != "true" ]; then
      echo "!!!!! Wrote $HOME/.tmuxinator/hack.yml"
    fi
}

function setup_tmux(){
  echo ">>>>> Setting up Tmux..."
  curl -s https://gist.githubusercontent.com/jondkinney/2040114/raw/tmux.conf > $HOME/.tmux.conf
  if [ "$defaults" != "true" ]; then
    echo "!!!!! Wrote $HOME/.tmux.conf"
  fi

  if [[ $OSTYPE =~ ^[darwin] ]]; then
    curl -s https://gist.githubusercontent.com/jondkinney/2040114/raw/tmux_mac.conf > $HOME/.tmux_mac.conf
    if [ "$defaults" != "true" ]; then
      echo "!!!!! Wrote $HOME/.tmux_mac.conf"
    fi
  fi

  if [[ $OSTYPE =~ ^[linux] ]]; then
    curl -s https://gist.githubusercontent.com/jondkinney/2040114/raw/tmux_linux.conf > $HOME/.tmux_linux.conf
    if [ "$defaults" != "true" ]; then
      echo "!!!!! Wrote $HOME/.tmux_linux.conf"
    fi
  fi

  mkdir -p $HOME/.tmux/plugins
  if [ "$defaults" != "true" ]; then
    echo "!!!!! Created $HOME/.tmux/plugins/"
  fi

  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
  if [ "$defaults" != "true" ]; then
    echo "!!!!! Cloned Tmux Plugin Manager into it"
  fi

  if [[ $TMUX == '' ]]; then
    tmux start-server # start a server but don't attach to it
    tmux new-session -d # create a new session but don't attach to it either
  fi
  bash $HOME/.tmux/plugins/tpm/scripts/install_plugins.sh # install the plugins
  if [ "$defaults" != "true" ]; then
    echo "!!!!! Installed specified tmux plugins"
  fi

  if [ "$defaults" != "true" ]; then
    echo ">>>>> Tmux setup complete"
  fi

  if [ "$defaults" == "true" ]; then
    setup_tmuxinator
  else
    read -p  "????? Add rails dev tmuxinator yaml file to $HOME/.tmuxinator (Y/n)"

    if [[ $REPLY =~ ^[Nn]$ ]]; then
      echo ">>>>> Skipping Tmuxinator rails dev config"
    else
      setup_tmuxinator
      echo "***** NOTE: make sure to install the tmuxinator gem in your global gemset (or another accessible place if you don't use RVM)"
    fi
  fi
}

if [ "$has_tmux_conf" == "true" ]; then
  echo "***** Note: You already have a Tmux configuration..."

  if [ "$defaults" == "true" ]; then
    backup_tmux
    setup_tmux
  else
    read -p  "????? Would you like to (b)ack it up, (o)verwrite it, or (s)kip Tmux all together (B/o/s)?"

    if [[ $REPLY =~ ^[Oo]$ ]]; then
      echo "!!!!! Deleting current Tmux setup..."
      rm -fv $HOME/.tmux.conf
      sudo rm -rf $HOME/.tmux
      setup_tmux
    elif [[ $REPLY =~ ^[Ss]$ ]]; then
      echo ">>>>> Skipping Tmux"
    else
      backup_tmux
      setup_tmux
    fi
  fi
else
  if [ "$defaults" == "true" ]; then
    setup_tmux
  else
    echo ">>>>> No previous Tmux config detected"
    read -p  "????? Would you like to add this Tmux config (Y/n)?"
    if [[ $REPLY =~ ^[Nn]$ ]]; then
      echo ">>>>> Skipping Tmux"
    else
      setup_tmux
    fi
  fi
fi


function backup_remote_clipboard(){
  echo "!!!!! Backing up remote clipboard setup. Appending -bak to the relevant files..."
  mv -fv $HOME/bin/pbcopy-remote $HOME/bin/pbcopy-remote-bak
  mv -fv $HOME/bin/pbpaste-remote $HOME/bin/pbpaste-remote-bak
}

function setup_remote_clipboard(){
  echo ">>>>> Setting up remote clipboard..."

  mkdir -p $HOME/bin/

  curl -s https://gist.githubusercontent.com/jondkinney/2040114/raw/pbcopy-remote > $HOME/bin/pbcopy-remote
  curl -s https://gist.githubusercontent.com/jondkinney/2040114/raw/pbpaste-remote > $HOME/bin/pbpaste-remote

  if [ "$defaults" != "true" ]; then
    echo "!!!!! Wrote $HOME/bin/pbcopy-remote"
    echo "!!!!! Wrote $HOME/bin/pbpaste-remote"
  fi

  read -p  "????? What port would you like to setup for pbcopy? (Default: 2222) "
  if [[ $REPLY =~ ^[0-9]{4}$ ]]; then
    sed -i -e "s/2222/$REPLY/" $HOME/bin/pbcopy-remote
  else
    echo "!!!!! Invalid port number, keeping default of 2222..."
  fi

  read -p  "????? What port would you like to setup for pbpaste? (Default: 2223) "
  if [[ $REPLY =~ ^[0-9]{4}$ ]]; then
    sed -i -e "s/2223/$REPLY/" $HOME/bin/pbpaste-remote
  else
    echo "!!!!! Invalid port number, keeping default of 2223..."
  fi

  chmod +x $HOME/bin/pb*-remote
}


if [[ $OSTYPE =~ ^[linux] ]]; then
  if [ "$has_pbcopy_remote" == "true" -o "$has_pbpaste_remote" == "true" ]; then
    echo "***** Note: You already have remote clipboard copy and/or paste setup..."

    if [ "$defaults" == "true" ]; then
      backup_remote_clipboard
      setup_remote_clipboard
    else
      read -p  "????? Would you like to (b)ack it up, (o)verwrite it, or (s)kip remote clipboard setup all together (B/o/s)?"

      if [[ $REPLY =~ ^[Oo]$ ]]; then
        echo "!!!!! Deleting current remote clipboard setup..."
        rm -fv $HOME/bin/pbpaste-remote
        rm -fv $HOME/bin/pbcopy-remote
        setup_remote_clipboard
      elif [[ $REPLY =~ ^[Ss]$ ]]; then
        echo ">>>>> Skipping Remote Clipboard Setup"
      else
        backup_remote_clipboard
        setup_remote_clipboard
      fi
    fi
  else
    if [ "$defaults" == "true" ]; then
      setup_remote_clipboard
    else
      echo ">>>>> No previous remote clipboard setup detected"
      read -p  "????? Would you like to add remote clipboard capabilities (Y/n)?"
      if [[ $REPLY =~ ^[Nn]$ ]]; then
        echo ">>>>> Skipping Remote Clipboard"
      else
        setup_remote_clipboard
      fi
    fi
  fi
fi

function backup_local_clipboard(){
  echo "!!!!! Backing up local clipboard setup. Appending -bak to the relevant files..."
  mv -fv $HOME/Library/LaunchAgents/pbcopy.plist $HOME/Library/LaunchAgents/pbcopy.plist-bak
  mv -fv $HOME/Library/LaunchAgents/pbpaste.plist $HOME/Library/LaunchAgents/pbpaste.plist-bak
}

function setup_local_clipboard(){
  echo ">>>>> Setting up local clipboard..."

  curl -s https://gist.githubusercontent.com/jondkinney/2040114/raw/pbcopy.plist > $HOME/Library/LaunchAgents/pbcopy.plist
  curl -s https://gist.githubusercontent.com/jondkinney/2040114/raw/pbpaste.plist > $HOME/Library/LaunchAgents/pbpaste.plist

  if [ "$defaults" != "true" ]; then
    echo "!!!!! Wrote $HOME/Library/LaunchAgents/pbcopy.plist"
    echo "!!!!! Wrote $HOME/Library/LaunchAgents/pbpaste.plist"
  fi

  read -p  "????? What port would you like to setup for pbcopy? (Default: 2222) "
  if [[ $REPLY =~ ^[0-9]{4}$ ]]; then
    sed -i -e "s/2222/$REPLY/" $HOME/Library/LaunchAgents/pbcopy.plist
    pbcopy_local_port=$REPLY
  else
    echo "!!!!! Invalid port number, keeping default of 2222..."
    pbcopy_local_port='2222'
  fi

  read -p  "????? What port would you like to setup for pbpaste? (Default: 2223) "
  if [[ $REPLY =~ ^[0-9]{4}$ ]]; then
    sed -i -e "s/2223/$REPLY/" $HOME/Library/LaunchAgents/pbpaste.plist
    pbpaste_local_port=$REPLY
  else
    echo "!!!!! Invalid port number, keeping default of 2223..."
    pbpaste_local_port='2223'
  fi

  echo "!!!!! Setting up pbcopy and pbpaste for launchctl"
  launchctl unload $HOME/Library/LaunchAgents/pbcopy.plist
  launchctl unload $HOME/Library/LaunchAgents/pbpaste.plist
  launchctl load $HOME/Library/LaunchAgents/pbcopy.plist
  launchctl load $HOME/Library/LaunchAgents/pbpaste.plist

  local_clipboard_was_setup="true"
}


if [[ $OSTYPE =~ ^[darwin] ]]; then
  if [ "$has_pbcopy_local" == "true" -o "$has_pbpaste_local" == "true" ]; then
    echo "***** Note: You already have local clipboard copy and/or paste setup..."

    if [ "$defaults" == "true" ]; then
      backup_local_clipboard
      setup_local_clipboard
    else
      read -p  "????? Would you like to (b)ack it up, (o)verwrite it, or (s)kip local clipboard setup all together (B/o/s)?"

      if [[ $REPLY =~ ^[Oo]$ ]]; then
        echo "!!!!! Deleting current local clipboard setup..."
        rm -fv $HOME/Library/LaunchAgents/pbcopy.plist
        rm -fv $HOME/Library/LaunchAgents/pbpaste.plist
        setup_local_clipboard
      elif [[ $REPLY =~ ^[Ss]$ ]]; then
        echo ">>>>> Skipping Local Clipboard Setup"
      else
        backup_local_clipboard
        setup_local_clipboard
      fi
    fi
  else
    if [ "$defaults" == "true" ]; then
      setup_local_clipboard
    else
      echo ">>>>> No previous local clipboard setup detected"
      read -p  "????? Would you like to add local clipboard capabilities (Y/n)?"
      if [[ $REPLY =~ ^[Nn]$ ]]; then
        echo ">>>>> Skipping Local Clipboard"
      else
        setup_local_clipboard
      fi
    fi
  fi
fi

if [ "$local_clipboard_was_setup" == "true" ]; then
  echo "!!!!! Please add the following configuration to your ~/.ssh/config file"
  echo "
    Host nickname_here
      HostName ip_address_or_hostname_here
      User your_username_here
      # Pick something other than 3000 to avoid port collisions in a shared environment
      LocalForward 3000 localhost:3000
      RemoteForward $pbcopy_local_port 127.0.0.1:$pbcopy_local_port
      RemoteForward $pbpaste_local_port 127.0.0.1:$pbpaste_local_port
      ForwardAgent yes

!!!!! You will then be able to ssh to the host using the above preferences automatically: ssh nickname_here

!!!!! NOTE: For pbcopy-remote & pbpaste-remote to work properly, make sure ~/bin is in your PATH on the remote machine!!
  "
fi
