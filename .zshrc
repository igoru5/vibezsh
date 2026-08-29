# ==============================================================================
# 🚀 THE ULTIMATE LIGHTWEIGHT DEV DOTFILE (BUT MAKE IT CAMP!_
# A highly optimized, high-contrast, and fun Zsh configuration 
# for developers who want a fast, responsive terminal with a touch of whimsy.
# (By @igoru5 // formatting and code review by Gemini)
# ==============================================================================

# Disable flow control (Ctrl+S/Ctrl+Q) for faster key responsiveness
unsetopt flowcontrol

# Enable prompt substitution and color support natively
autoload -U colors && colors
export CLICOLOR=1
export LSCOLORS="exfxcxdxbxegedabagacad"

# ==============================================================================
# 🛠 ALIASES & UTILITIES
# ==============================================================================

# Navigation & File Management
alias ll='ls -lah'
alias ls='ls -GFh'
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias md='mkdir -p'
alias o='open .'
alias show='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
alias hide='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'
alias path='echo $PATH | tr ":" "\n"'

# Development & System Diagnostics
alias py='python3'
alias pip='pip3'
alias ports='lsof -i -P -n | grep LISTEN'
alias myip='curl -s --max-time 3 ifconfig.me && echo ""'
alias disk='du -sh * | sort -hr'

# Git Shortcuts
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias gl='git log --oneline --graph --decorate --all'
alias grep='grep --color=auto'

# Zsh Configuration Shortcuts
alias zconfig="code ~/.zshrc"
alias zreload="source ~/.zshrc"
alias theme='set_theme'

# Secure VS Code terminal integration preventing dock duplication via bundle ID routing
code() {
  if [ -z "$1" ]; then
    open -b com.microsoft.VSCode
  else
    open -b com.microsoft.VSCode "$1"
  fi
}

newdata() {
  if [[ -z "$1" ]]; then
    print -P "%F{196}Error: Directory name required.%f"
    return 1
  fi
  mkdir -p -- "$1" && cd -- "$1"
  uv init
  uv add pandas numpy matplotlib seaborn duckdb jupyter
  code .
}

# ==============================================================================
# 🎮 SAFE, ALLOC-OPTIMIZED FUN & BREAK FUNCTIONS
# ==============================================================================

weather() {
  curl -s --max-time 3 "wttr.in/${1:-Saue}?format=3"
}

matrix() {
  echo -e "\e[1;40m" ; clear ; while :; do echo $LINES $COLUMNS $(( $RANDOM % $COLUMNS)) $(( $RANDOM % 72 )) ;sleep 0.05; done|awk '{ letters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()"; c=$4; letter=substr(letters,c,1);a[$3]=0;for(x in a) {o=a[x];a[x]=a[x]+1; printf "\033[%s;%sH\033[2;32m%s",o,x,letter; printf "\033[%s;%sH\033[1;37m%s\033[0;0H",a[x],x,letter;if (a[x] >= $1) { a[x]=0; } }}'
}

dogfact() {
  curl -s --max-time 3 "https://dogapi.dog/api/v1/facts" | python3 -c "import sys, json; print('🐶 ' + json.load(sys.stdin)['facts'][0])"
}

dadjoke() {
  curl -s --max-time 3 -H "Accept: text/plain" "https://icanhazdadjoke.com/"
  echo ""
}

magic8() {
  local -a responses=(
    "It is certain." "Without a doubt." "You may rely on it."
    "Reply hazy, try again." "Ask again later." "Better not tell you now."
    "Outlook not so good." "Very doubtful." "Signs point to yes."
    "Most definitely debuggable."
  )
  print -P "%F{214}🎱 Magic 8-Ball says: %F{231}${responses[$((RANDOM % ${#responses[@]} + 1))]}%f"
}

flip() {
  if (( RANDOM % 2 == 0 )); then
    print -P "%F{226}🪙 Heads!%f"
  else
    print -P "%F{110}🪙 Tails!%f"
  fi
}

roll() {
  local sides=${1:-6}
  print -P "%F{205}🎲 Rolled a $sides-sided die: %F{231}$(( (RANDOM % sides) + 1 ))%f"
}

tarot() {
  local -a deck=(
    "The Fool" "The Magician" "The High Priestess" "The Empress" "The Emperor"
    "The Hierophant" "The Lovers" "The Chariot" "Strength" "The Hermit"
    "Wheel of Fortune" "Justice" "The Hanged Man" "Death" "Temperance"
    "The Devil" "The Tower" "The Star" "The Moon" "The Sun" "Judgement" "The World"
    "Ace of Cups" "2 of Cups" "3 of Cups" "4 of Cups" "5 of Cups" "6 of Cups" "7 of Cups" "8 of Cups" "9 of Cups" "10 of Cups" "Page of Cups" "Knight of Cups" "Queen of Cups" "King of Cups"
    "Ace of Pentacles" "2 of Pentacles" "3 of Pentacles" "4 of Pentacles" "5 of Pentacles" "6 of Pentacles" "7 of Pentacles" "8 of Pentacles" "9 of Pentacles" "10 of Pentacles" "Page of Pentacles" "Knight of Pentacles" "Queen of Pentacles" "King of Pentacles"
    "Ace of Swords" "2 of Swords" "3 of Swords" "4 of Swords" "5 of Swords" "6 of Swords" "7 of Swords" "8 of Swords" "9 of Swords" "10 of Swords" "Page of Swords" "Knight of Swords" "Queen of Swords" "King of Swords"
    "Ace of Wands" "2 of Wands" "3 of Wands" "4 of Wands" "5 of Wands" "6 of Wands" "7 of Wands" "8 of Wands" "9 of Wands" "10 of Wands" "Page of Wands" "Knight of Wands" "Queen of Wands" "King of Wands"
  )

  local -a positions=("Past" "Present" "Future")
  print -P "\n%F{213}🔮 DRAWING YOUR THREE-CARD TAROT SPREAD 🔮%f\n"

  for pos in $positions; do
    local idx=$(( (RANDOM % ${#deck[@]} ) + 1 ))
    local card="${deck[$idx]}"
    local orientation="Upright ✨"
    (( RANDOM % 2 == 1 )) && orientation="Reversed 🙃"
    print -P "%F{220}▶ $pos:%f %F{231}$card%f (%F{110}$orientation%f)"
  done
  print ""
}

inspire() {
  local -a quotes=(
    "Your code compiles on the first try in an alternate timeline."
    "Every bug is just an undocumented feature waiting for purpose."
    "You are one refactor away from inner peace."
    "Even the cleanest production environment started as a blinking cursor."
  )
  print -P "%F{51}💡 Dev Mantra: %F{231}${quotes[$((RANDOM % ${#quotes[@]} + 1))]}%f"
}

# ==============================================================================
# 🎨 HIGH-CONTRAST OPTIMISED THEME ENGINE
# ==============================================================================

set_theme() {
  local choice="${1:l}"
  local theme_roll
  local a1 a2 a3 a4
  local bar_top bar_bot hl_path

  if [[ -z "$choice" || "$choice" == "random" ]]; then
    theme_roll=$((RANDOM % 15))
  else
    case "$choice" in
      autumn) theme_roll=0 ;;
      forest) theme_roll=1 ;;
      ocean) theme_roll=2 ;;
      sunset) theme_roll=3 ;;
      espresso) theme_roll=4 ;;
      girlypop) theme_roll=5 ;;
      sakura) theme_roll=6 ;;
      indie) theme_roll=7 ;;
      minimalist) theme_roll=8 ;;
      rainbow) theme_roll=9 ;;
      lgbtq) theme_roll=10 ;;
      vinyl) theme_roll=11 ;;
      plantdad) theme_roll=12 ;;
      dachshund) theme_roll=13 ;;
      cmyk) theme_roll=14 ;;
      *) print -P "%F{196}Theme not found! Rolling random.%f"; theme_roll=$((RANDOM % 15)) ;;
    esac
  fi

  # Optimized high-contrast palette calibrated for pure black background displays
  case $theme_roll in
    0)
      c_frame=208; c_user=221; c_path=214; c_accent=202; t_name="Autumn Dev"; t_greeting="(🍂 ˘ ᵕ ˘ ) Warm cider and crisp code."
      a1="  \\|/   "; a2=" --*--  "; a3="  /|\\   "; a4="   |    "
      ;;
    1)
      c_frame=114; c_user=193; c_path=156; c_accent=82; t_name="Forest Druid"; t_greeting="( 🌿 🌿 ) The roots grow deep."
      a1="   /\\   "; a2="  //\\\\  "; a3=" ///\\\\\\ "; a4="   ||   "
      ;;
    2)
      c_frame=45; c_user=123; c_path=81; c_accent=39; t_name="Deep Ocean"; t_greeting="( 🌊 ⋆ 🌊) Dive into the code."
      a1="   |\\   "; a2="  /| \\  "; a3=" /____\\ "; a4=" ~~~~~~ "
      ;;
    3)
      c_frame=209; c_user=220; c_path=214; c_accent=197; t_name="Sunset Dawn"; t_greeting="( 🌅 ᵕ 🌅 ) A new day to build."
      a1=" \\ | /  "; a2=" --O--  "; a3=" _/ \\_  "; a4=" ~~~~~~ "
      ;;
    4)
      c_frame=180; c_user=222; c_path=216; c_accent=173; t_name="Espresso"; t_greeting="c[_] ( ☕ ˘ ☕) Fueling the logic."
      a1="  ( (   "; a2="   ) )  "; a3=" |====|D"; a4=" \\____/ "
      ;;
    5)
      c_frame=213; c_user=225; c_path=219; c_accent=199; t_name="Girlypop"; t_greeting="( 💅 ✧ 💅 ) Slaying the bugs! ✨"
      a1=" (\\  /) "; a2=" ( \\/ ) "; a3="  \\  /  "; a4="   \\/   "
      ;;
    6)
      c_frame=225; c_user=231; c_path=218; c_accent=212; t_name="Sakura"; t_greeting="( 🌸 ◕ 🌸 ) Gentle winds and code."
      a1="   _    "; a2=" _( )_  "; a3="(_   _) "; a4="  (_)   "
      ;;
    7)
      c_frame=178; c_user=222; c_path=214; c_accent=166; t_name="Indie"; t_greeting="( 🎧 • 🎧 ) Low-fi beats and indie streets."
      a1=" ┌────┐ "; a2=" │o  o│ "; a3=" │ == │ "; a4=" └────┘ "
      ;;
    8)
      c_frame=250; c_user=231; c_path=255; c_accent=245; t_name="Minimalist"; t_greeting="( ▫️ _ ▫️ ) Focus. No distractions."
      a1=" ┌──┐   "; a2=" │\\/│   "; a3=" │/\\│   "; a4=" └──┘   "
      ;;
    9)
      c_frame=51; c_user=213; c_path=226; c_accent=46; t_name="Rainbow Prism"; t_greeting="( 🌈 ✨ 🌈 ) Pure spectral bandwidth."
      a1=" \\|/°  "; a2=" -O-*-- "; a3=" /|\\.   "; a4="  | v   "
      ;;
    10)
      c_frame=213; c_user=159; c_path=231; c_accent=205; t_name="LGBTQ+ Pride"; t_greeting="( 🏳️‍🌈 ✊ 🏳️‍🌈 ) Diversity powers innovation."
      a1=" ⚧️🏳️‍⚧️ "; a2=" ══════ "; a3="  \\||/  "; a4="   \/   "
      ;;
    11)
      c_frame=246; c_user=228; c_path=252; c_accent=196; t_name="Vinyl Lover"; t_greeting="( 💽 • 💽 ) Analog warmth, digital execution."
      a1="  __!_  "; a2=" / (o) \\"; a3=" \\_____/"; a4="  [===] "
      ;;
    12)
      c_frame=114; c_user=192; c_path=156; c_accent=82; t_name="Plant Dad"; t_greeting="( 🌱 🪴 🌿 ) Cultivating clean logic."
      a1="   _v_  "; a2="  (🪴)  "; a3="  / | \\ "; a4=" (____) "
      ;;
    13)
      c_frame=173; c_user=222; c_path=221; c_accent=136; t_name="Dachshund Lover"; t_greeting="( 🐾 🌭 🐾 ) Long body, high performance."
      a1="   ___  "; a2=" =.._\\  "; a3=" (____/ "; a4="  OO    "
      ;;
    14)
      c_frame=51; c_user=201; c_path=226; c_accent=231; t_name="CMYK Process"; t_greeting="( 🖨️ 📉 🖨️ ) Cyan, Magenta, Yellow, White."
      a1="  [C]   "; a2="  [M]   "; a3="  [Y]   "; a4="  [W]   "
      ;;
  esac

  export c_frame c_user c_path c_accent t_name

  bar_top="%F{$c_frame}████████████████%F{$c_user}████████████████%F{$c_path}████████████████%F{$c_accent}████████████%f"
  bar_bot="%F{$c_accent}████████████████%F{$c_path}████████████████%F{$c_user}████████████████%F{$c_frame}████████████%f"

  print -P "\n%F{$c_frame}████▓▒░ %F{$c_accent}${a1} %F{$c_frame}░▒▓${bar_top}"
  print -P "%F{$c_user}████▓▒░ %F{$c_path}${a2} %F{$c_user}░▒▓  %F{$c_path}✨ ${t_name}%f"
  print -P "%F{$c_path}████▓▒░ %F{$c_user}${a3} %F{$c_path}░▒▓  %f${t_greeting}%f"
  print -P "%F{$c_accent}████▓▒░ %F{$c_frame}${a4} %F{$c_accent}░▒▓${bar_bot}\n"

  PROMPT="%F{$c_frame}╭─[ %F{$c_user}%n %F{$c_frame}@ %m ]─[ %F{$c_path}%~ %F{$c_frame}]
╰─%F{$c_accent}❯%f "

  # Highly efficient cached check for syntax-highlighting plugins
  for hl_path in /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
                 /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; do
    if [[ -f "$hl_path" ]]; then
      source "$hl_path"
      ZSH_HIGHLIGHT_STYLES[command]="fg=$c_path,bold"
      ZSH_HIGHLIGHT_STYLES[alias]="fg=$c_path,bold"
      break
    fi
  done
}

# ==============================================================================
# 📋 DYNAMIC CHEAT SHEETS  (rewritten for guaranteed alignment)
# ==============================================================================
#
# WHY THE OLD BOX BROKE:
#   1. The title line used hand-counted spaces on both sides of $t_name, but
#      $t_name is a different length for every theme ("Ocean" vs
#      "Dachshund Lover"), so it could only ever be correct for one theme.
#   2. Emoji (✨) count as ONE character to the shell but render as TWO
#      terminal columns on macOS, silently shifting anything padded by hand.
#   3. Every row's padding was typed manually, which is easy to miscount
#      and impossible to verify at a glance.
#
# THE FIX: never hand-count spaces. Compute padding from the real string
# length at runtime, and keep box interior text plain ASCII (no emoji)
# so "1 character" always equals "1 terminal column".
# ------------------------------------------------------------------------

# Pad (or truncate) $1 to exactly $2 visible columns.
_cs_pad() {
  local s="$1" w="$2" len=${#1} e=""
  if (( len >= w )); then
    print -n -- "${s:0:$w}"
  else
    local n=$(( w - len ))
    print -n -- "${s}${(l:$n:: :)e}"
  fi
}

# Top/middle/bottom border, e.g. _cs_border "╭" "╮"
_cs_border() {
  local left="$1" right="$2" e=""
  print -P "${FRAME}${left}${(l:78::─:)e}${right}%f"
}

# Empty row (keeps the interior exactly 78 columns wide, matching the border)
_cs_blank() {
  local e=""
  print -P "${FRAME}│${(l:78:: :)e}│%f"
}

# A "command / description" row. $3 = label column width (default 30).
_cs_row() {
  local label="$1" desc="$2" labelw="${3:-30}"
  local plabel="$(_cs_pad "$label" "$labelw")"
  local full="$(_cs_pad "${plabel}${desc}" 76)"
  local descpart="${full:$labelw}"
  print -P "${FRAME}│ ${PATHC}${plabel}${FRAME}${descpart} │%f"
}

# A section header row, e.g. "GIT WORKFLOW"
_cs_header() {
  local content="$(_cs_pad "$1" 76)"
  print -P "${FRAME}│ ${USERC}${content}${FRAME} │%f"
}

cheatsheet() {
  # Snapshot the current theme's colors as %F tokens for print -P
  local FRAME="%F{$c_frame}" PATHC="%F{$c_path}" USERC="%F{$c_user}"
  local title="* ${t_name} CHEAT SHEET *"
  local tlen=${#title}
  local lp=$(( (76 - tlen) / 2 ))
  local rp=$(( 76 - tlen - lp ))
  local e=""
  local titleline="${(l:$lp:: :)e}${title}${(l:$rp:: :)e}"

  _cs_border "╭" "╮"
  _cs_blank
  print -P "${FRAME}│ ${PATHC}${titleline}${FRAME} │%f"
  _cs_blank
  _cs_border "├" "┤"

  _cs_header "CONFIG & THEMES"
  _cs_row "zconfig, zreload" "Edit Zsh config, refresh terminal"
  _cs_row "theme <name>" "Switch theme (e.g. theme cmyk)"
  _cs_row "themes" "View all available themes & colors"
  _cs_blank

  _cs_header "NAVIGATION & MAC"
  _cs_row "ll, ls, c" "List details, list w/ color, clear"
  _cs_row ".., ..." "Go up 1 or 2 folders"
  _cs_row "md, o" "Make nested folders, open in Finder"
  _cs_row "show / hide" "Toggle hidden files in Finder"
  _cs_row "disk" "List heaviest files/folders by size"
  _cs_blank

  _cs_header "DATA, PYTHON & DEV"
  _cs_row "newdata <x>" "Create data project + uv env + VS Code"
  _cs_row "py, pip, ports" "Python3, pip3, view active local ports"
  _cs_row "myip" "Check external network IP address"
  _cs_blank

  _cs_header "GIT WORKFLOW"
  _cs_row "gs, ga, gc" "Git status, add all, commit -m"
  _cs_row "gp, gpl" "Git push, pull"
  _cs_row "gd, gb, gco" "Git diff, branches, checkout"
  _cs_row "gl" "Visual ASCII git tree log"
  _cs_blank

  _cs_header "FUN & BREAKS"
  _cs_row "weather <x>" "Terminal weather (e.g. weather ny)"
  _cs_row "matrix" "Matrix rain (Ctrl+C to exit)"
  _cs_row "magic8, flip" "Ask Magic 8-Ball or flip a coin"
  _cs_row "roll <sides>" "Roll a die (default 6-sided)"
  _cs_row "tarot, inspire" "3-card tarot spread or dev mantra"
  _cs_row "dogfact, dadjoke" "Random dog trivia or classic dad joke"

  _cs_border "╰" "╯"
}

themes() {
  print -P "\n%F{214}🎨 AVAILABLE THEMES (15 VIBES) 🎨%f"
  print -P "Type %F{110}theme <name>%f to switch, or %F{110}theme random%f to roll.\n"
  print -P "  %F{208}██%F{221}██%F{214}██%F{202}██%f  autumn"
  print -P "  %F{114}██%F{193}██%F{156}██%F{082}██%f  forest"
  print -P "  %F{045}██%F{123}██%F{081}██%F{039}██%f  ocean"
  print -P "  %F{209}██%F{220}██%F{214}██%F{197}██%f  sunset"
  print -P "  %F{180}██%F{222}██%F{216}██%F{173}██%f  espresso"
  print -P "  %F{213}██%F{225}██%F{219}██%F{199}██%f  girlypop"
  print -P "  %F{225}██%F{231}██%F{218}██%F{212}██%f  sakura"
  print -P "  %F{178}██%F{222}██%F{214}██%F{166}██%f  indie"
  print -P "  %F{250}██%F{231}██%F{255}██%F{245}██%f  minimalist"
  print -P "  %F{051}██%F{213}██%F{226}██%F{046}██%f  rainbow"
  print -P "  %F{213}██%F{159}██%F{231}██%F{205}██%f  lgbtq"
  print -P "  %F{246}██%F{228}██%F{252}██%F{196}██%f  vinyl"
  print -P "  %F{114}██%F{192}██%F{156}██%F{082}██%f  plantdad"
  print -P "  %F{173}██%F{222}██%F{221}██%F{136}██%f  dachshund"
  print -P "  %F{051}██%F{201}██%F{226}██%F{231}██%f  cmyk\n"
}

# ==============================================================================
# 🎲 INITIALIZATION
# ==============================================================================
set_theme "random"