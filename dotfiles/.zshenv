#!/usr/bin/zsh
#
# File: .zshenv
# Path: $HOME
# Tags: zsh shell
# Description: zsh env config
# Last update: 11/12/2019 20:22
# Author: Colpshift
#

### path
typeset -U path
path=($HOME/.local/bin $HOME/.scripts $HOME/.rbenv/bin $HOME/.cargo/bin $GEM_HOME/bin /bin /usr/bin /sbin /usr/sbin /usr/local/bin $path[@])

### fzf
# using fd
export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# search
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
# preview
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

### cheat
export CHEAT_CONFIG_PATH="$HOME/.config/cheat/conf.yml"
export CHEAT_USE_FZF=true

### ruby
export GEM_HOME="$HOME/.local/share/gem/ruby/2.7.0/bin"

### rust
source "$HOME/.cargo/env"

### Perl
PATH="/home/colps/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/colps/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/colps/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/colps/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/colps/perl5"; export PERL_MM_OPT;

### font preview ueberzug 
export FONTPREVIEW_PREVIEW_TEXT="ABCDEFGHIJKLM\nNOPQRSTUVWXYZ\nabcdefghijklm\nnopqrstuvwxyz\n1234567890\n< != == ->\n | #[ |> <$> ~@"

