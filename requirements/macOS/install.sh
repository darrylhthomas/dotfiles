#!/bin/bash

set -u

fail() {
	printf "%s\n" "$@" >&2
	exit 1
}

require_confirmation() {
	read -r -p "$1 (y/N): " -n 1 proceed
	if ! [[ "${proceed}" == $'y' || "${proceed}" == $'Y' ]]; then
		printf "\nFine, be that way. I didn't want to do it anyway. ";
		fail "Aborting."
	fi
	printf "\n"
}

echo "Creating temporary directory…"
TEMPORARY_DIRECTORY=$(mktemp -d)
if ! [[ -d "${TEMPORARY_DIRECTORY}" && -w "${TEMPORARY_DIRECTORY}" ]]; then
	fail "Unable to create temporary directory. Aborting."
fi
cd "${TEMPORARY_DIRECTORY}" || fail "Unable to change to temporary directory."
pwd

echo "Checking for Oh-my-zsh…"
echo "ZSH environment variable is \"$ZSH\""
if [ -z "$ZSH" ] || [ ! -d "${ZSH}" ]; then
	require_confirmation "OMG! Couldn't find OMZ! Install it now?"
	
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || fail "An error occurred while installing Oh-my-zsh."
else
	echo "Found."
fi

echo "Checking for Homebrew installation…"
if ! which "brew"; then
	require_confirmation "Homebrew not found. Shall we install it now?"
	
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || fail "An error occurred while installing Homebrew."
else
	echo "Found."
fi

check_and_install_from_brew() {
	echo "Checking for $1…"
	if ! which "$1"; then
		require_confirmation "$1 not found. Install it via Homebrew?"
		brew install "$1" || fail "Could not install $1."
	else
		echo "Found."
	fi
}

printf "\nChecking for required packages available from Homebrew…\n\n"

check_and_install_from_brew tmux
check_and_install_from_brew lazygit
check_and_install_from_brew pyright
check_and_install_from_brew nvim
check_and_install_from_brew fzf
check_and_install_from_brew bat
check_and_install_from_brew zoxide
check_and_install_from_brew stow
check_and_install_from_brew fd
check_and_install_from_brew wget
check_and_install_from_brew xcbeautify
check_and_install_from_brew coreutils


printf "\nChecking for JetBrainsMono nerd-fonts…\n"
FONTS_DIRECTORY="$HOME/Library/Fonts"
if [ ! -f "${FONTS_DIRECTORY}/JetBrainsMonoNerdFont-Regular.ttf" ]; then
	require_confirmation "Nerd-fonts not found. Download and install them?"
	echo "Downloading and installing JetBrainsMono nerd-fonts…"
	( curl -L -O 'https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip' && unzip "JetBrainsMono.zip" -d "JetBrainsMono" && mv -n JetBrainsMono/*.ttf "$FONTS_DIRECTORY" ) || fail "An error occurred while downloading and installing nerd-fonts."
else
	echo "Found."
fi

check_and_install_from_github() {
	echo "Checking for $1…"
	if ! [ -d "$2" ]; then
		( mkdir -p "$2" && git clone "$3" "$2" ) || fail "Could not clone $1."
	else
		echo "Found."
	fi
}

printf "\nChecking for dependencies available from Github…\n\n"

check_and_install_from_github "ZSH Autosuggestions" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"
check_and_install_from_github "ZSH Syntax Highlighting" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting"
check_and_install_from_github tpm "$HOME/.tmux/plugins/tpm" "https://github.com/tmux-plugins/tpm"
check_and_install_from_github "ZSH Theme: nord-extended" "$ZSH/themes/nord-extended" "https://github.com/fxbrit/nord-extended"

printf "\nBacking up existing dotfiles…\n\n"
dotfiles_to_backup=(
	"$HOME/.zshrc"
	"$HOME/.config/nvim"
	"$HOME/.config/tmux"
)

for dotfile_to_backup in "${dotfiles_to_backup[@]}"
do
	if [ -f "$dotfile_to_backup" ]; then
		echo "Moving $dotfile_to_backup to ${dotfile_to_backup}-pre-dotfiles…"
		mv "$dotfile_to_backup" "${dotfile_to_backup}-pre-dotfiles"
	fi
done
printf "\nStowing dotfiles…\n\n"
stow -v -d ~/dotfiles -S ghostty -S nvim -S tmux -S zsh -S xcode-themes || fail "Could not stow dotfiles."


printf "\nSetting Xcode theme…\n"
defaults write XCFontAndColorCurrentTheme -string "Nord.xccolortheme"
defaults write XCFontAndColorCurrentDarkTheme -string "Nord.xccolortheme"

printf "\nSetting Terminal.app window settings…\n"
terminal_window_settings_file="$HOME/dotfiles/requirements/macOS/Nord.terminal"
if ! [ -f "$terminal_window_settings_file" ]; then
	fail "Nord.terminal window settings file not found."
fi

defaults export com.apple.Terminal temp.plist || fail "Could not export existing Terminal defaults."
plutil -remove 'Window Settings'.Nord temp.plist
plutil -insert 'Window Settings'.Nord -json '{}' -append temp.plist || fail "Could not add Nord dictionary key to window settings."
for key in $(plutil -convert raw -o - "$terminal_window_settings_file")
do
    value_type=$(plutil -type "$key" -o - "$terminal_window_settings_file")
    value=$(plutil -extract "$key" raw -o - "$terminal_window_settings_file")
    plutil -insert 'Window Settings'.Nord."$key" -"$value_type" "${value}" temp.plist || fail "Could not insert key into Nord dictionary."
done

defaults import com.apple.Terminal temp.plist || fail "Could not import new Terminal defaults."
rm temp.plist

defaults write com.apple.Terminal 'Default Window Settings' -string Nord || fail "Could not write default window settings key to Terminal defaults."
defaults write com.apple.Terminal 'Startup Window Settings' -string Nord || fail "Could not write startup window settings key to Terminal defaults."

printf "\n\nDone! You will need to restart Xcode and Terminal.app (and open a new window) for changes to take effect.\n"
printf "Remember to install tmux plugins using 'ctrl-<space> I' after entering tmux.\n\n"
exit 0
