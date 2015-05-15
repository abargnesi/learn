#!/usr/bin/env bash

# install vim-flavor dependency, alternatively:
#   gem install vim-flavor
bundle install --path=gems

# install vim plugins (flavors) under current directory
#   e.g. ./flavors
bundle exec vim-flavor install --vimfiles-path=.

# use example .vimrc to add working directory to runtimepath
# and load flavors
vim -u ./.vimrc -o Gemfile VimFlavor* lib/*.rb
