if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

fish_add_path ~/.cargo/bin/

set fish_greeting

alias clr=clear
alias vi=nvim
alias lzg=lazygit
alias zj=zellij
alias ls="eza --icons"
alias cat=bat
