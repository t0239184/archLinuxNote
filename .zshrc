# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH="/home/alan/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


#******************** PATH ********************
# [Server] Apache2
#export APACHE_HOME=/etc/apache2/
#export APACHE_BASE=/usr/local/WebServer/Documents/
# [Server] Apache Tomcat 8.0.36
#export CATALINA_HOME=/usr/local/apache-tomcat-8.0.36
#export WEBAPP=$CATALINA_HOME/webapps/
# [Database] MySQL
#export MYSQL_HOME=/usr/local/mysql
#export PATH=$MYSQL_HOME/bin:$PATH
# [Package Control]Maven
export MAVEN_HOME="/opt/maven/"
export M2_HOME=$MAVEN_HOME
export PATH="$JAVA_HOME/bin/:$PATH"
#export PATH=$MAVEN_HOME/bin:$PATH
# [Language] Nodejs
#export NODE_HOME=/Users/An/.nvm/versions/node/v8.1.4/
#export PATH=$NODE_HOME/bin:$PATH
# [Language] Ruby
#export RUBY_HOME=/usr/local/Cellar/ruby/2.4.1_1
#export PATH=$RUBY_HOME/bin:$PATH

#[Language] Java
export JAVA_HOME="/usr/lib/jvm/default"
export PATH="$JAVA_HOME/bin/:$PATH"

# Set JDK Version for PATH function
#function setjdk() {
#    if [ $# -ne 0 ]; then
#        removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
#            if [ -n "${JAVA_HOME+x}" ]; then
#                removeFromPath $JAVA_HOME
#            fi
#        export JAVA_HOME=`/usr/libexec/java_home -v $@`
#        export PATH=$JAVA_HOME/bin:$PATH
#    fi
#}
# Remove JDK Version for PATH function
#function removeFromPath() {
#    export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
#}
#setjdk 1.8              # Set JDK Version

#******************* Terminal ********************
# Set ls color
DIR=Ex
SYM_LINK=Gx
SOCKET=Fx
PIPE=dx
EXE=Cx
BLOCK_SP=Dx
CHAR_SP=Dx
EXE_SUID=hb
EXE_GUID=ad
DIR_STICKY=Ex
DIR_WO_STICKY=Ex
export LSCOLORS="$DIR$SYM_LINK$SOCKET$PIPE$EXE$BLOCK_SP$CHAR_SP$EXE_SUID$EXE_GUID$DIR_STICKY$DIR_WO_STICKY"
export CLICOLOR=true

#******************** Alias **********************
alias rm='rm -ri'
alias ls='ls -aF --color=always'
alias ll='ls -aFl --color=always'
alias cls='clear'
alias cd..='cd ..'
alias cd....='cd .. && cd ..'
#alias du='ncdu'
#alias top='htop'
#alias df='dfc'
alias quit='exit'
alias youtube-mp3='youtube-dl --embed-thumbnail --add-metadata --extract-audio --audio-format mp3 '
alias youtube-mp4='youtube-dl --embed-thumbnail --add-metadata --format mp4 '
alias vi='vim --noplugin'
#alias tomcat-start='$CATALINA_HOME/bin/startup.sh'
#alias tomcat-shutdown='$CATALINA_HOME/bin/shutdown.sh'
#alias wget-website='wget --recursive --no-clobber --page-requisites --html-extension --#convert-links --restrict-file-names=windows --no-parent'
#alias tree='tree -a'
#******************** Man Page ********************
export LESS_TERMCAP_mb=$'\E[1;31m'  #begin blinking
export LESS_TERMCAP_md=$'\E[4;32m'  #begin bold
export LESS_TERMCAP_me=$'\E[0m'     #end mode
export LESS_TERMCAP_so=$'\E[0l31m'  #begin standout-mode-info box
export LESS_TERMCAP_se=$'\E[0m'     #end stand-mode
export LESS_TERMCAP_us=$'\E[0;33m'  #begin underline
