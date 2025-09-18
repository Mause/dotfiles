set -x otrace

pkg i neovim git git-lfs
pkg i clang make
pkg i sccache
pkg i ripgrep
pkg i gitoxide
pkg i fd bat
pkg i ruff
pkg i libxml2 libxslt
pkg i diff-so-fancy
pkg i uv
pkg i gh direnv chafa
pkg i file
pkg i which
pkg i tmux
pkg i fish
pkg i lnav
pkg i lazygit
pkg i nodejs
pkg i rust rust-analyzer
pkg i fzf crystal
cargo install harper-ls --locked
cargo install emmylua_ls --locked
cargo install lucky_commit --locked --no-default-features
