# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
ZSH_DISABLE_COMPFIX=true
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="racoonbyte01"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	sudo
	rsync
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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ls="lsd"
alias nv="nvim"
# alias tmux='tmux attach-session -t 0 2>/dev/null || tmux'
alias pipes='pipes.sh -p 2 -t 1 -B'
alias lsblk='lsblk -o NAME,SIZE,FSTYPE,UUID,MOUNTPOINTS'
alias weather='curl wttr.in'
alias ip='ip --color=auto'
alias fastfetch='fastfetch -l ~/.config/fastfetch/logo'
alias wheather-api='curl wttr.in/'
alias battime='upower -d | grep "time to empty"; sudo systemctl stop upower.service'
alias ssh='TERM="xterm-256color" ssh'
alias lofi='mpv --no-save-watch-history --no-video --no-resume-playback "https://www.youtube.com/watch?v=jfKfPfyJRdk"'
alias update-path='export PATH=$PATH'
# alias gpg='DISPLAY="" gpg'
function video-to-davinci(){
	ffmpeg -c:v h264_cuvid -i $1 -c:v dnxhd -profile:v dnxhr_hq -pix_fmt yuv422p -c:a pcm_s16le $2;
}
# alias battime='echo $(($(cat /sys/class/power_supply/BAT1/charge_full)-$(cat /sys/class/power_supply/BAT1/charge_now) / $(cat /sys/class/power_supply/BAT1/current_now)))'
function rmk(){
    scrub -p dod $1
    shred -zun 2 -v $1
}
function matrixeffect() {
	if [[ -f $1 ]]; then
		STR=$(cat $1)
		TIME=$2
	else
		STR=$(cat)
		TIME=$1
	fi
	for (( i=0; i<${#STR}; i++)); do
		echo -nE "${STR:$i:1}"
		if [[ $TIME != '' ]]; then	
			sleep $TIME
		else
			sleep .1
		fi
	done
	echo ''
}
function pcupdate(){
	figlet -f ANSI\ Shadow 'Update Packages:' -c | matrixeffect .001
	logger -t pcupdate -p syslog.info '[*] Starting manual update.'
	# pacman
	logger -t pcupdate -p syslog.info '[*] [pacman] Starting pacman updates...'
	## pacman list
	logger -t pcupdate -p syslog.info '[*] [pacman] Getting pacman packages list to updates...'
	echo n | sudo pacman -Syu
	pacman -Qu | sed -e 's/^/[+] [pacman] /' | logger -t pcupdate -p syslog.info \
		|| logger -t pcupdate -p syslog.error '[!] [pacman] Error getting pacman package to updates...'
	## !pacman list
	## pacman update
	logger -t pcupdate -p syslog.info '[*] [pacman] Starting pacman packages update...'
	sudo pacman -Syu --noconfirm \
		&& logger -t pcupdate -p syslog.info '[*] [pacman] End package updates of pacman.' \
		|| logger -t pcupdate -p syslog.error '[!] [pacman] Error package updates of pacman.'
	## !pacman update
	## pacman cache
	logger -t pcupdate -p syslog.info '[*] [pacman] Starting delete pacman cache...'
	sudo pacman -Sc --noconfirm \
		&& logger -t pcupdate -p syslog.info '[*] [pacman] Cache pacman deleted.' \
		|| logger -t pcupdate -p syslog.error '[!] [pacman] Error at delete pacman cache.'
	## !pacman cache
	logger -t pcupdate -p syslog.info '[*] [pacman] End pacman updates.'
	# !pacman
	# ---
	# # yay
	# logger -t pcupdate -p syslog.info '[*] [yay] Starting yay updates...'
	# ## yay list
	# logger -t pcupdate -p syslog.info '[*] [yay] Getting yay packages list to updates...'
	# echo n | yay -Syu
	# yay -Qu | sed -e 's/^/[+] [yay] /' | logger -t pcupdate -p syslog.info \
	# 	|| logger -t pcupdate -p syslog.error '[!] [yay] Error getting yay packages list to updates...'
	# ## !yay list
	# ## yay update
	# logger -t pcupdate -p syslog.info '[*] [yay] Starting yay packages update...'
	# yay -Syu --noconfirm \
	# 	&& logger -t pcupdate -p syslog.info '[*] [yay] End package updates of yay.' \
	# 	|| logger -t pcupdate -p syslog.error '[!] [yay] Error package updates of yay.'
	# ## !yay update
	# ## yay cache
	# logger -t pcupdate -p syslog.info '[*] [yay] Starting delete yay cache...'
	# yay -Sc --noconfirm \
	# 	&& logger -t pcupdate -p syslog.info '[*] [yay] Cache yay deleted.' \
	# 	|| logger -t pcupdate -p syslog.error '[!] [yay] Error at delete yay cache.'
	# ## !yay cache
	# logger -t pcupdate -p syslog.info '[*] [yay] End yay updates.'
	# # !yay
	# ---
	# orphan packages
	figlet -f ANSI\ Shadow 'Delete Orphan Packages:' -c | matrixeffect .001
	logger -t pcupdate -p syslog.info '[*] Starting delete orphan packages...'
	## list orphan packages
	sudo pacman -Qtdq | sed -e 's/^/[+] /' | logger -t pcupdate -p syslog.info \
		|| logger -t pcupdate -p syslog.error '[!] Error getting orphan packages...'
	## !list orphan packages
	sudo pacman -Rns $(pacman -Qtdq) --noconfirm \
		&& logger -t pcupdate -p syslog.info '[*] Orphan packages deleted.' \
		|| logger -t pcupdate -p syslog.error '[!] Error deleting orphan packages.'
	# orphan packages
	# ---
	# clear cache
	figlet -f ANSI\ Shadow 'Clean Cache:' -c | matrixeffect .001
	logger -t pcupdate -p syslog.info '[*] Starting clean system cache...'
	sudo rm -rf /var/cache/pacman/pkg/download-* \
		&& logger -t pcupdate -p syslog.info '[*] rm /var/cache/pacman/pkg/download- success.' \
		|| logger -t pcupdate -p syslog.error '[!] rm /var/cache/pacman/pkg/download- error.'
	rm -rf $HOME/.cache/ &> /dev/null \
		&& logger -t pcupdate -p syslog.info '[*] rm $HOME/.cache/ success.' \
		|| logger -t pcupdate -p syslog.error '[!] rm $HOME/.cache/ error.'
	logger -t pcupdate -p syslog.info '[*] End clean system cache.'
	# !clear cache
	logger -t pcupdate -p syslog.info '[*] End manual update.'
}
function cursor()
{
	echo -ne "\033[6n"            # ask the terminal for the position
	read -s -d\[ garbage          # discard the first part of the response
	read -s -d R foo              # store the position in bash variable 'foo'
	echo -ne "$foo\n" # print the position
}
function libvirt()
{
	if [[ $1 == 'start' ]]; then
		sudo systemctl start libvirtd spice-vdagentd
		virt-manager &> /dev/null &; disown
	elif [[ $1 == 'stop' ]]; then
		sudo systemctl stop libvirtd.service libvirtd-admin.socket libvirtd-ro.socket libvirtd.socket spice-vdagentd.service spice-vdagentd.socket
	fi
}
function tv.es(){
	mpv $(curl https://iptv-org.github.io/iptv/index.m3u | grep -i "$1"".es" -A 1 | tail -n 1)
}
function mpv-tui(){
	TITLE_CONTINUE=$(awk -F\" '{ print $10 }' $HOME/.local/state/mpv/watch_history.jsonl | sed '/^\s*$/d' | fzf --preview=)
	mpv "$(grep -w \"$TITLE_CONTINUE\" $HOME/.local/state/mpv/watch_history.jsonl | awk -F\" '{ print $6 }')"
}
function sm64()
{
	cd /run/media/racoonbyte01/wd-green/other/us_pc
	prime-run /run/media/racoonbyte01/wd-green/other/us_pc/sm64.us &
}
function random-mac ()
{
	sudo ifconfig $1 down
	sudo macchanger -r $1
	sudo ifconfig $1 up
}
functions screensaveoff()
{
	xset -dpms
	xset s off
	xset s noblank
}
# functions zram-on ()
# {
# 	sudo modprobe zram
# 	sudo zramctl /dev/zram0 --algorithm zstd --size "$(($(grep -Po 'MemTotal:\s*\K\d+' /proc/meminfo)/2))KiB"
# 	sudo mkswap -U clear /dev/zram0
# 	sudo swapon --discard --priority 100 /dev/zram0
# }
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# end=$(tput cup 9999 0)
# PS1="%{${end}%} $PS1"
# logger -t upload -p user.info -f updates
