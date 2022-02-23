test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
setopt interactive_comments hist_ignore_dups  octal_zeroes   #no_prompt_cr
setopt no_hist_no_functions no_always_to_end  append_history list_packed
setopt inc_append_history   complete_in_word     auto_pushd # no_auto_menu
setopt pushd_ignore_dups    no_glob_complete  no_glob_dots   c_bases
setopt numeric_glob_sort      promptsubst    auto_cd #no_share_history
setopt rc_quotes            extendedglob      notify

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

autoload up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

#bindkey -v
[[ -n "$terminfo[kpp]"   ]] && bindkey "$terminfo[kpp]"   up-line-or-beginning-search   # PAGE UP
[[ -n "$terminfo[knp]"   ]] && bindkey "$terminfo[knp]"   down-line-or-beginning-search # PAGE DOWN
[[ -n "$terminfo[khome]" ]] && bindkey "$terminfo[khome]" beginning-of-line             # HOME
[[ -n "$terminfo[kend]"  ]] && bindkey "$terminfo[kend]"  end-of-line                   # END
[[ -n "$terminfo[kdch1]" ]] && bindkey "$terminfo[kdch1]" delete-char                   # DELETE
[[ -n "$terminfo[kbs]"   ]] && bindkey "$terminfo[kbs]"   backward-delete-char          # BACKSPACE

bindkey "^A"      beginning-of-line     "^E"      end-of-line
bindkey "^?"      backward-delete-char  "^H"      backward-delete-char
bindkey "^W"      backward-kill-word    "\e[1~"   beginning-of-line
bindkey "\e[7~"   beginning-of-line     "\e[H"    beginning-of-line
bindkey "\e[4~"   end-of-line           "\e[8~"   end-of-line
bindkey "\e[F"    end-of-line           "\e[3~"   delete-char
bindkey "^J"      accept-line           "^M"      accept-line
bindkey "^T"      accept-line           "^R"      history-incremental-search-backward

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[^[[C" forward-word
bindkey "^[^[[D" backward-word
bindkey "kLFT5" forward-word
bindkey "kRIT5" backward-word


autoload colors
colors

if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit.git "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/z-a-rust \
    zdharma-continuum/z-a-as-monitor \
    zdharma-continuum/z-a-patch-dl \
    zdharma-continuum/z-a-bin-gem-node \
    romkatv/zsh-defer
### End of Zinit's installer chunk


zinit light-mode for \
    romkatv/zsh-defer

ZSH_THEME=robbyrussell
#zinit wait lucid for \
 #   OMZL::git.zsh \
 #   http://github.com/robbyrussell/oh-my-zsh/raw/master/lib/git.zsh \
 #   OMZ::lib/theme-and-appearance.zsh \
 #   OMZL::prompt_info_functions.zsh \
 #   OMZ::themes/robbyrussell.zsh-theme
#zinit cdclear -q # <- forget completions provided up to this moment
setopt promptsubst

zinit snippet OMZL::git.zsh
zinit snippet OMZL::prompt_info_functions.zsh 
zinit snippet OMZ::lib/theme-and-appearance.zsh
zinit snippet OMZ::themes/robbyrussell.zsh-theme
#zinit snippet OMZT::gnzh
#zinit light NicoSantangelo/Alpharized

zinit ice pick'poetry.zsh'
zinit wait"2" lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 atload"!_zsh_autosuggest_start; finish_setup;" \
    zsh-users/zsh-autosuggestions \
 blockf \
    OMZ::plugins/pip \
    zsh-users/zsh-history-substring-search  \
    zdharma-continuum/history-search-multi-word \
    OMZP::colored-man-pages \
    agkozak/zsh-z \
    sudosubin/zsh-poetry \
    MichaelAquilina/zsh-autoswitch-virtualenv \
        zsh-users/zsh-completions \




#zinit light marlonrichert/zsh-autocomplete
zstyle ':completion:*' insert-tab false


# zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
#     atpull'%atclone' pick"clrs.zsh" nocompile'!' \
#     atload'zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}'
# zinit light trapd00r/LS_COLORS
export LS_COLORS="bd=0;38;2;102;217;239;48;2;51;51;51:pi=0;38;2;0;0;0;48;2;102;217;239:so=0;38;2;0;0;0;48;2;249;38;114:tw=0:ln=0;38;2;249;38;114:ow=0:ex=1;38;2;249;38;114:*~=0;38;2;122;112;112:mi=0;38;2;0;0;0;48;2;255;74;68:fi=0:cd=0;38;2;249;38;114;48;2;51;51;51:di=0;38;2;102;217;239:st=0:or=0;38;2;0;0;0;48;2;255;74;68:no=0:*.d=0;38;2;0;255;135:*.p=0;38;2;0;255;135:*.m=0;38;2;0;255;135:*.a=1;38;2;249;38;114:*.h=0;38;2;0;255;135:*.o=0;38;2;122;112;112:*.t=0;38;2;0;255;135:*.z=4;38;2;249;38;114:*.c=0;38;2;0;255;135:*.r=0;38;2;0;255;135:*.pp=0;38;2;0;255;135:*.gv=0;38;2;0;255;135:*.rs=0;38;2;0;255;135:*.7z=4;38;2;249;38;114:*.fs=0;38;2;0;255;135:*.hh=0;38;2;0;255;135:*.ex=0;38;2;0;255;135:*.ko=1;38;2;249;38;114:*.gz=4;38;2;249;38;114:*.jl=0;38;2;0;255;135:*.ml=0;38;2;0;255;135:*css=0;38;2;0;255;135:*.pm=0;38;2;0;255;135:*.cs=0;38;2;0;255;135:*.sh=0;38;2;0;255;135:*.lo=0;38;2;122;112;112:*.cc=0;38;2;0;255;135:*.mn=0;38;2;0;255;135:*.hs=0;38;2;0;255;135:*.rm=0;38;2;253;151;31:*.vb=0;38;2;0;255;135:*.nb=0;38;2;0;255;135:*.ll=0;38;2;0;255;135:*.go=0;38;2;0;255;135:*.ps=0;38;2;230;219;116:*.kt=0;38;2;0;255;135:*.di=0;38;2;0;255;135:*.bz=4;38;2;249;38;114:*.ui=0;38;2;166;226;46:*.td=0;38;2;0;255;135:*.bc=0;38;2;122;112;112:*.el=0;38;2;0;255;135:*.so=1;38;2;249;38;114:*.pl=0;38;2;0;255;135:*.md=0;38;2;226;209;57:*.py=0;38;2;0;255;135:*.cp=0;38;2;0;255;135:*.hi=0;38;2;122;112;112:*.js=0;38;2;0;255;135:*.cr=0;38;2;0;255;135:*.ts=0;38;2;0;255;135:*.la=0;38;2;122;112;112:*.xz=4;38;2;249;38;114:*.rb=0;38;2;0;255;135:*.as=0;38;2;0;255;135:*.deb=4;38;2;249;38;114:*.exs=0;38;2;0;255;135:*.fon=0;38;2;253;151;31:*.def=0;38;2;0;255;135:*.ltx=0;38;2;0;255;135:*.sty=0;38;2;122;112;112:*.zsh=0;38;2;0;255;135:*.eps=0;38;2;253;151;31:*.gif=0;38;2;253;151;31:*.pkg=4;38;2;249;38;114:*.iso=4;38;2;249;38;114:*.arj=4;38;2;249;38;114:*.zip=4;38;2;249;38;114:*.ind=0;38;2;122;112;112:*.ipp=0;38;2;0;255;135:*.bak=0;38;2;122;112;112:*.erl=0;38;2;0;255;135:*.ogg=0;38;2;253;151;31:*.apk=4;38;2;249;38;114:*.dot=0;38;2;0;255;135:*.tar=4;38;2;249;38;114:*.sxw=0;38;2;230;219;116:*.svg=0;38;2;253;151;31:*.tgz=4;38;2;249;38;114:*.tbz=4;38;2;249;38;114:*.exe=1;38;2;249;38;114:*.ico=0;38;2;253;151;31:*.mid=0;38;2;253;151;31:*.avi=0;38;2;253;151;31:*.dmg=4;38;2;249;38;114:*.xlr=0;38;2;230;219;116:*.xmp=0;38;2;166;226;46:*.bmp=0;38;2;253;151;31:*.jpg=0;38;2;253;151;31:*.mkv=0;38;2;253;151;31:*.cpp=0;38;2;0;255;135:*.ppt=0;38;2;230;219;116:*TODO=1:*.vob=0;38;2;253;151;31:*.idx=0;38;2;122;112;112:*.bbl=0;38;2;122;112;112:*.c++=0;38;2;0;255;135:*.wma=0;38;2;253;151;31:*.m4a=0;38;2;253;151;31:*.out=0;38;2;122;112;112:*.elm=0;38;2;0;255;135:*.img=4;38;2;249;38;114:*.rst=0;38;2;226;209;57:*.awk=0;38;2;0;255;135:*.bsh=0;38;2;0;255;135:*.txt=0;38;2;226;209;57:*.psd=0;38;2;253;151;31:*.otf=0;38;2;253;151;31:*.mli=0;38;2;0;255;135:*.sxi=0;38;2;230;219;116:*.aif=0;38;2;253;151;31:*.ics=0;38;2;230;219;116:*.dpr=0;38;2;0;255;135:*.tex=0;38;2;0;255;135:*.kex=0;38;2;230;219;116:*.hpp=0;38;2;0;255;135:*.csv=0;38;2;226;209;57:*.asa=0;38;2;0;255;135:*.doc=0;38;2;230;219;116:*.ods=0;38;2;230;219;116:*.wav=0;38;2;253;151;31:*.csx=0;38;2;0;255;135:*.yml=0;38;2;166;226;46:*.rpm=4;38;2;249;38;114:*.tmp=0;38;2;122;112;112:*.pps=0;38;2;230;219;116:*.cxx=0;38;2;0;255;135:*.bcf=0;38;2;122;112;112:*.odt=0;38;2;230;219;116:*.tsx=0;38;2;0;255;135:*.ppm=0;38;2;253;151;31:*.vcd=4;38;2;249;38;114:*.bag=4;38;2;249;38;114:*.fnt=0;38;2;253;151;31:*.bz2=4;38;2;249;38;114:*.swp=0;38;2;122;112;112:*.log=0;38;2;122;112;112:*.pod=0;38;2;0;255;135:*.dox=0;38;2;166;226;46:*.blg=0;38;2;122;112;112:*.tml=0;38;2;166;226;46:*.fls=0;38;2;122;112;112:*.com=1;38;2;249;38;114:*.git=0;38;2;122;112;112:*.inl=0;38;2;0;255;135:*.ttf=0;38;2;253;151;31:*.gvy=0;38;2;0;255;135:*.hxx=0;38;2;0;255;135:*.inc=0;38;2;0;255;135:*.sql=0;38;2;0;255;135:*.pyc=0;38;2;122;112;112:*.xcf=0;38;2;253;151;31:*.swf=0;38;2;253;151;31:*.wmv=0;38;2;253;151;31:*.jar=4;38;2;249;38;114:*.pdf=0;38;2;230;219;116:*.pas=0;38;2;0;255;135:*.ps1=0;38;2;0;255;135:*.nix=0;38;2;166;226;46:*.pbm=0;38;2;253;151;31:*.ilg=0;38;2;122;112;112:*.pro=0;38;2;166;226;46:*.rtf=0;38;2;230;219;116:*.png=0;38;2;253;151;31:*.kts=0;38;2;0;255;135:*.fsx=0;38;2;0;255;135:*.bat=1;38;2;249;38;114:*.dll=1;38;2;249;38;114:*.tcl=0;38;2;0;255;135:*.cfg=0;38;2;166;226;46:*.cgi=0;38;2;0;255;135:*.mir=0;38;2;0;255;135:*.clj=0;38;2;0;255;135:*.flv=0;38;2;253;151;31:*.mpg=0;38;2;253;151;31:*.bin=4;38;2;249;38;114:*.pgm=0;38;2;253;151;31:*.bst=0;38;2;166;226;46:*.mov=0;38;2;253;151;31:*.xls=0;38;2;230;219;116:*.tif=0;38;2;253;151;31:*hgrc=0;38;2;166;226;46:*.odp=0;38;2;230;219;116:*.php=0;38;2;0;255;135:*.htm=0;38;2;226;209;57:*.rar=4;38;2;249;38;114:*.xml=0;38;2;226;209;57:*.htc=0;38;2;0;255;135:*.mp3=0;38;2;253;151;31:*.pid=0;38;2;122;112;112:*.toc=0;38;2;122;112;112:*.aux=0;38;2;122;112;112:*.sbt=0;38;2;0;255;135:*.mp4=0;38;2;253;151;31:*.fsi=0;38;2;0;255;135:*.epp=0;38;2;0;255;135:*.h++=0;38;2;0;255;135:*.lua=0;38;2;0;255;135:*.ini=0;38;2;166;226;46:*.vim=0;38;2;0;255;135:*.bib=0;38;2;166;226;46:*.m4v=0;38;2;253;151;31:*.make=0;38;2;166;226;46:*.yaml=0;38;2;166;226;46:*.conf=0;38;2;166;226;46:*.lisp=0;38;2;0;255;135:*.orig=0;38;2;122;112;112:*.psd1=0;38;2;0;255;135:*.tiff=0;38;2;253;151;31:*.h264=0;38;2;253;151;31:*.diff=0;38;2;0;255;135:*.flac=0;38;2;253;151;31:*.fish=0;38;2;0;255;135:*.json=0;38;2;166;226;46:*.psm1=0;38;2;0;255;135:*.hgrc=0;38;2;166;226;46:*.epub=0;38;2;230;219;116:*.tbz2=4;38;2;249;38;114:*.pptx=0;38;2;230;219;116:*.lock=0;38;2;122;112;112:*.bash=0;38;2;0;255;135:*.html=0;38;2;226;209;57:*.java=0;38;2;0;255;135:*.jpeg=0;38;2;253;151;31:*.purs=0;38;2;0;255;135:*.docx=0;38;2;230;219;116:*.dart=0;38;2;0;255;135:*.less=0;38;2;0;255;135:*.mpeg=0;38;2;253;151;31:*.xlsx=0;38;2;230;219;116:*.toml=0;38;2;166;226;46:*.rlib=0;38;2;122;112;112:*.scala=0;38;2;0;255;135:*passwd=0;38;2;166;226;46:*.ipynb=0;38;2;0;255;135:*README=0;38;2;0;0;0;48;2;230;219;116:*.cabal=0;38;2;0;255;135:*.cache=0;38;2;122;112;112:*.cmake=0;38;2;166;226;46:*.patch=0;38;2;0;255;135:*.class=0;38;2;122;112;112:*.shtml=0;38;2;226;209;57:*shadow=0;38;2;166;226;46:*.dyn_o=0;38;2;122;112;112:*.swift=0;38;2;0;255;135:*.toast=4;38;2;249;38;114:*.mdown=0;38;2;226;209;57:*.xhtml=0;38;2;226;209;57:*.config=0;38;2;166;226;46:*.gradle=0;38;2;0;255;135:*COPYING=0;38;2;182;182;182:*.dyn_hi=0;38;2;122;112;112:*INSTALL=0;38;2;0;0;0;48;2;230;219;116:*.matlab=0;38;2;0;255;135:*.groovy=0;38;2;0;255;135:*TODO.md=1:*.flake8=0;38;2;166;226;46:*.ignore=0;38;2;166;226;46:*LICENSE=0;38;2;182;182;182:*TODO.txt=1:*.gemspec=0;38;2;166;226;46:*setup.py=0;38;2;166;226;46:*Makefile=0;38;2;166;226;46:*.desktop=0;38;2;166;226;46:*Doxyfile=0;38;2;166;226;46:*configure=0;38;2;166;226;46:*README.md=0;38;2;0;0;0;48;2;230;219;116:*.cmake.in=0;38;2;166;226;46:*.fdignore=0;38;2;166;226;46:*.kdevelop=0;38;2;166;226;46:*.markdown=0;38;2;226;209;57:*COPYRIGHT=0;38;2;182;182;182:*.rgignore=0;38;2;166;226;46:*.DS_Store=0;38;2;122;112;112:*SConscript=0;38;2;166;226;46:*INSTALL.md=0;38;2;0;0;0;48;2;230;219;116:*SConstruct=0;38;2;166;226;46:*.gitconfig=0;38;2;166;226;46:*.gitignore=0;38;2;166;226;46:*.scons_opt=0;38;2;122;112;112:*.localized=0;38;2;122;112;112:*README.txt=0;38;2;0;0;0;48;2;230;219;116:*CODEOWNERS=0;38;2;166;226;46:*Dockerfile=0;38;2;166;226;46:*LICENSE-MIT=0;38;2;182;182;182:*INSTALL.txt=0;38;2;0;0;0;48;2;230;219;116:*MANIFEST.in=0;38;2;166;226;46:*Makefile.am=0;38;2;166;226;46:*Makefile.in=0;38;2;122;112;112:*.gitmodules=0;38;2;166;226;46:*.travis.yml=0;38;2;230;219;116:*.synctex.gz=0;38;2;122;112;112:*CONTRIBUTORS=0;38;2;0;0;0;48;2;230;219;116:*.applescript=0;38;2;0;255;135:*configure.ac=0;38;2;166;226;46:*.fdb_latexmk=0;38;2;122;112;112:*appveyor.yml=0;38;2;230;219;116:*.clang-format=0;38;2;166;226;46:*LICENSE-APACHE=0;38;2;182;182;182:*CMakeLists.txt=0;38;2;166;226;46:*.gitattributes=0;38;2;166;226;46:*CMakeCache.txt=0;38;2;122;112;112:*CONTRIBUTORS.md=0;38;2;0;0;0;48;2;230;219;116:*.sconsign.dblite=0;38;2;122;112;112:*requirements.txt=0;38;2;166;226;46:*CONTRIBUTORS.txt=0;38;2;0;0;0;48;2;230;219;116:*package-lock.json=0;38;2;122;112;112:*.CFUserTextEncoding=0;38;2;122;112;112"
export LSCOLORS=GxFxCxDxBxegedabagaced

#zplugin snippet OMZ::themes/robbyrussell.zsh-theme
#zplugin snippet OMZT::robbyrussell.zsh-theme
# zinit light marlonrichert/zcolors
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'


zstyle ':completion:*' menu select

# zinit ice pick"async.zsh" src"pure.zsh"
# zinit light sindresorhus/pure

# autoload -Uz compinit
# compinit

# zinit cdreplay -q   # -q is for quiet; actually run all the `compdef's saved before
#                     #`compinit` call (`compinit' declares the `compdef' function, so
#                     # it cannot be used until `compinit' is ran; Zinit solves this
#                     # via intercepting the `compdef'-calls and storing them for later
#                     # use with `zinit cdreplay')

finish_setup(){
  load_pyenv
  which pygmentize 2> /dev/null >&2 && export LESSOPEN="| pygmentize -g -f terminal256 %s"
  command -v exa 2>/dev/null >&2 && alias ls='exa'
  alias tmux="tmux -CC"

  export PATH="/usr/local/opt/perl/bin:$PATH"
  eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
  eval "$(frum init)"
}

zinit wait"2" lucid atinit'zpcompinit; zpcdreplay;' for \
 Aloxaf/fzf-tab


function kubectl() {
    if ! type __start_kubectl >/dev/null 2>&1; then
        source <(command kubectl completion zsh)
    fi

    command kubectl "$@"
}






export EDITOR=emacs

if [[ `uname` == "Darwin" ]]; then
  export PATH="/opt/local/bin:/usr/local/sbin:/opt/local/sbin:$PATH:/Users/shaananc/.local/bin"
  #export PATH="/usr/local/opt/binutils/bin:$PATH"
  export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PATH:$PYENV_ROOT/bin"
  CFLAGS="-I/usr/local/opt/openssl@1.1/include -I/usr/local/opt/readline/include -I/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include"
  LDFLAGS="-L/usr/local/opt/openssl@1.1/lib -L/usr/local/opt/readline/lib -L/usr/local/opt/zlib/lib"

  zinit wait"2" lucid for \
    zsh-users/zsh-apple-touchbar

fi


  

export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4 -R -X -F'



# kube config
export KUBECONFIG=$KUBECONFIG:$HOME/.kube/config
export KUBEMASTER=158.130.4.34


### Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish


# zsh-defer -c 'export CFLAGS="-I$(brew --prefix openssl)/include -I$(brew --prefix readline)/include -I$(xcrun --show-sdk-path)/usr/include"'
# zsh-defer -c 'export LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix readline)/lib -L$(brew --prefix zlib)/lib"'

#SDKROOT=/Applications/Xcode-beta.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk 

#if [[ `uname` == "Darwin" ]]; then
#if [ $(brew info llvm 2>&1 | grep -c "Built from source on") -eq 0 ]; then
  #we are using a homebrew clang, need new flags
#export LDFLAGS="-L$(xcrun --show-sdk-path)/usr/lib -L$(brew --prefix)/opt/llvm/lib -Wl,-rpath,$(brew --prefix)/opt/llvm/lib"
#export CFLAGS="-I/usr/local/opt/llvm/include -isysroot $(xcrun --show-sdk-path)"
#export CPPFLAGS="-I/usr/local/opt/llvm/include -I/usr/local/opt/llvm/include/c++/v1/"
#export PATH="/usr/local/opt/llvm/bin:$PATH"
#export SDKROOT="$(xcrun --show-sdk-path)"
#fi
#fi

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
        autoload -Uz add-zle-hook-widget
        function zle_application_mode_start { echoti smkx }
        function zle_application_mode_stop { echoti rmkx }
        add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
        add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

alias gdb="gdb -quiet"
alias python="ipython"

