#!/bin/bash

function getBashDir(){
  src="${BASH_SOURCE[0]}"
  while [ -h "$src" ]; do # resolve $source until the file is no longer a symlink
    dir="$( cd -P "$( dirname "$src" )" && pwd )"
    src="$(readlink "$src")"
    # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    [[ $src != /* ]] && src="$dir/$src" 
  done
  dir="$( cd -P "$( dirname "$src" )" && pwd )"
  echo "$dir"
}
src_d=$(getBashDir)


path="$HOME/.vimrc"
if [[ -f $path ]]; then
    pathbak="${path}.bak-dotvim"
    if [[ ! -f $pathbak ]]; then
        mv "$path" "$pathbak"
    fi
fi
if [[ ! -f $path ]]; then
    ln -s "${src_d}/vimrc" "$path"
fi

path="$HOME/.gvimrc"
if [[ -f $path ]]; then
    pathbak="${path}.bak-dotvim"
    if [[ ! -f $pathbak ]]; then
        mv "$path" "$pathbak"
    fi
fi
if [[ ! -f $path ]]; then
    ln -s "${src_d}/gvimrc" "$path"
fi

