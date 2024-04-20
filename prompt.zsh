autoload colors && colors
# cheers, @ehrenmurdick
# # http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  if $(! $git status -s &> /dev/null)
  then
    echo ""
  else
    if [[ $($git status --porcelain) == "" ]]
    then
      echo "on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
  ref=$($git symbolic-ref HEAD 2>/dev/null) || return
  # echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
  echo "${ref#refs/heads/}"
}

unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}


zelda () {
  if (( $+commands[pmset] )) ; then
    battery="$(pmset -g ps | awk 'NR==2' | perl -pe 's/.*?(\d+)%.*/\1/')"

    if [[ $battery -lt 17 ]]; then
      echo "♥️ 🤍🤍🤍🤍🤍"
    elif [[ $battery -lt 34 ]]; then
      echo "♥️ ♥️ 🤍🤍🤍🤍"
    elif [[ $battery -lt 51 ]]; then
      echo "♥️ ♥️ ♥️ 🤍🤍🤍"
    elif [[ $battery -lt 68 ]]; then
      echo "♥️ ♥️ ♥️ ♥️ 🤍🤍"
    elif [[ $battery -lt 85 ]]; then
      echo "♥️ ♥️ ♥️ ♥️ ♥️ 🤍"
    else
      echo "♥️ ♥️ ♥️ ♥️ ♥️ ♥️ "
    fi
  fi
}

directory_name() {
  echo "%{$fg_bold[green]%}%2/%\/%{$reset_color%}"
}

export PROMPT=$'\n$(directory_name) $(git_dirty)$(need_push)\n› '
# set_prompt () {
#   export RPROMPT=$(zelda)
# }

# precmd() {
# #   title "zsh" "%m" "%55<...<%~"
#   set_prompt
# }

