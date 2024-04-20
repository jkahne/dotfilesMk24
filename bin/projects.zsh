compdef _p p

function _p () {
  _files -W /Users/`whoami`/projects/ -
  return 1
}

function p () {
  if [[ $1 == 'open' ]]; then
    REPLACEMENT="s/\\/Users\\/`whoami`\\/projects\\///g"
    CURRENT_PROJECT_DIR=`pwd | gsed $REPLACEMENT`
    open https://$CURRENT_PROJECT_DIR
  else
    string=`echo $1 | gsed 's/\.git$//' | gsed 's/[:\@\/]/ /g'`
    a=("${(s/ /)string}")

    domain=$a[1]
    organization=$a[2]
    code_base=$a[3]

    projects_path=$HOME/projects
    full_path=$projects_path/$domain/$organization/$code_base

    if [[ -d $full_path ]]; then
      cd /Users/`whoami`/projects/$1

      if [[ -a ./.nvmrc ]]; then
        nvm use
      fi
    else
      mkdir -p $projects_path/$domain/$organization
      cd $projects_path/$domain/$organization

      git clone git@$domain:$organization/$code_base.git

      cd $code_base
    fi
  fi
}

