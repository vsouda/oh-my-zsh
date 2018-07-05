# Tweaked from ys
# http://ysmood.org/wp/2013/03/my-ys-terminal-theme/

# Machine name.
function box_name {
  if [[ "$HOST" == *"BOSMM"* || "$HOST" == "Leos-MacBook-Pro.local" ]]; then
    echo "home"
  else
    echo ${HOST%%.*}
  fi
}

# Check and set environment
function env {
  if [[ "$HOST" == *"prod"* ]]; then
    echo "$fg[yellow]%\ prod"
  elif [[ "$HOST" == *"rc"* ]]; then
    echo "$fg[yellow]%\ stag"
  elif [[ "$HOST" == *"edge"* ]]; then
    echo "$fg[yellow]%\ edge"
  fi
}

# Directory info.
local current_dir='${PWD/#$HOME/~}'

# VCS
YS_VCS_PROMPT_COLOR="%{$fg[cyan]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}x"
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}o"

# Git info.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%} > ${YS_VCS_PROMPT_COLOR}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"

function get_kube_info() {
  if [ -f "$HOME/.kube/config" ]; then
    echo "$(grep -m 1 'current-context:' ~/.kube/config | cut -d ' ' -f 2)"
  else
    echo "no-conf"
  fi
}
local kube_info='$(get_kube_info)'

# Prompt format: \n # USER at MACHINE in DIRECTORY on git:BRANCH STATE [TIME] \n $
PROMPT="
%{$fg[cyan]%}%n\
%{$fg[white]%} @ \
%{$fg[green]%}$(box_name)%{$reset_color%} \
+ %{$fg[red]%}${kube_info}%{$reset_color%} \
%{$fg[white]%}> \
%{$fg[yellow]%}%c%{$reset_color%}\
${git_info}
%{$terminfo[bold]$fg[yellow]%}λ %{$reset_color%}"
