alias mv='mv -i'
alias l="eza -la"
alias exa="eza"

alias b="bundle"
alias bi="bundle config set path 'vendor' && bundle install"
alias bil="bi --local"
alias bu="b update"
alias be="bundle exec"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"

alias rubocop-nike="bin/rake lint:ruby:current:fix"
alias nike="bin/rake lint:ruby:current:fix"
alias pair="bundle exec git pair"

alias tls="tmux ls"
alias t="tmux attach -t"
# alias til="tmux attach -t til"
# alias web="tmux attach -t web"
# alias monte="tmux attach -t monte"
# alias dot="tmux attach -t dot"

alias rroutes="bin/rails routes | fzf -e"
alias proutes="mix phx.routes | fzf -e"

alias updateclam="freshclam -v"

alias vim="nvim"
alias n="nvim"
alias d="cd ~/.dotfiles && nvim"
# nv => NeoVim
alias nv="cd ~/.config/nvim && nvim"
# wn => Work Notes
alias wn="cd ~/projects/worknotes && nvim"
alias icloud="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/"
alias cdx="cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Brain/"
alias om="overmind start -f Procfile.dev"
alias postmaster="brew services stop postgres; cd /opt/homebrew/var/postgres; rm postmaster.pid; cd -; brew services start postgres;"
alias squash='git rebase -i main'
alias sync='git add -u . && git commit -m "Minor changes. Commit message skipped." && git pull --rebase && git push'
# alias fbr='git branch --sort=-committerdate | grep -v HEAD | string trim | fzf +s | xargs git checkout'
alias fco="git branch --sort=-committerdate -r | fzf +m | awk '{print $1}' | xargs git switch"
alias branch_cleanup='git branch | grep -v "main" | xargs git branch -D'
# alias remove_merged_branches='git branch --no-color --merged | command grep -vE "^(\+|\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 git branch -d'

alias gm="start_dev"
alias mig="bin/rails db:migrate"


alias lz="lazygit"
alias lg="lazygit"
alias lzconfig="vim ~/Library/Application\ Support/lazygit/config.yml"
alias lgconfig="vim ~/Library/Application\ Support/lazygit/config.yml"

alias gw="git ci -m'wip'"
alias gwip="git ci -m'wip'"
alias gwipp="git ci -m'wip' && git push"
# alias gpom="git push origin main"
alias pr="gh pr view --web"
alias prc="gh pr create --web"

# alias vc='vim $(git diff --name-only origin/master)'
# alias vcl='vim $(git diff --name-only HEAD^ HEAD)'

alias tldrf='tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,70% | xargs tldr'
alias cbr='git branch --sort=-committerdate | fzf --header "Checkout Recent Branch"  --preview "git diff {1} --color=always" | xargs git checkout'
# ghpr -> in zshrc.  It's a function.  I don't know why

# It shows the commits to the release branch that have not yet been released including the author of the commit.
# alias pending='!git log $(gh release list -L 1 | cut -f 1)..@ --pretty="%an - %s" | sort'

# alias start='vim ~/dropbox/n/notes/day-start-checklist.md'
# alias pn='vim ~/dropbox/n/notes/project-notes.md'
alias format='be standardrb --fix; npm run pretty;'
alias jsontidy="pbpaste | jq '.' | pbcopy"

# alias work="cp ~/.npmrc.work ~/.npmrc;"
# alias home="cp ~/.npmrc.home ~/.npmrc;"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# alias st="tag --add starred ."
# alias un="tag --add up next ."
# alias starred="tag -f starred"
# alias upnext="tag -f 'up next'"
# alias gun='cd $(tag -f "up next" | fzf)'
# alias gst='cd $(tag -f starred | fzf)'
# alias vv='cd ~/.dotfiles && vim ./vim/vimrc.symlink'

# # alias gco="git branch | fzf | sed 's/\* //g' | xargs -I '{}' git checkout {}"
alias gco='git checkout $(git branch | fzf)'

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
# alias rt='ctags -R --exclude=node_modules --exclude=vendor --exclude=.svn --exclude=.git --exclude=log --exclude=tmp * '


alias short_prompt="export PS1='$ '"

alias fix="git diff --name-only | uniq | xargs nvim"

# Recursively delete `.DS_Store` files
alias cleanup="find . -name '*.DS_Store' -or -name '*.keep' -type f  -ls -delete"

# ROT13-encode text. Works for decoding, too! ;)
alias rot13='tr a-zA-Z n-za-mN-ZA-M'

# Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
# (useful when executing time-consuming commands)
# usage:  > long_command & badge
alias badge="tput bel"


# ruby
alias cpwd="pwd | ruby -pe'\$_.chomp!' | pbcopy"
alias rshare="ruby -rubygems -e \"['thin', 'rack', 'socket'].each {|file| require file };"\
  " Thin::Server.start(IPSocket.getaddress(Socket.gethostname), 7777) {"\
  " use Rack::CommonLogger; run Rack::Directory.new(Dir.pwd) }\""
  alias duo='du -sh $(du -s * | sort -k1n | ruby -nae '\''puts '\$'F[1..-1].join("?")'\'')'


# Pipe my public key to my clipboard. Fuck you, pay me.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

alias web="cd ~/projects/active/jkahnecom; vim ./src/pages/posts/\[page\].astro"
alias blog="cd ~/projects/active/jkahnecom; vim ./src/pages/posts/\[page\].astro"


# alias dbreset="mix ecto.reset"


