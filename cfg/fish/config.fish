if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

alias clr=clear
alias vi=nvim
alias lzg=lazygit
alias zj=zellij
alias ls="exa --icons"