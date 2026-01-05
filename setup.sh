#!/bin/bash
set -e

DOTFILES_DIR="$HOME/dotfiles"

# 色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# シンボリックリンク作成（既存ファイルのバックアップ付き）
create_symlink() {
    local src="$1"
    local dest="$2"

    if [ ! -e "$src" ]; then
        warn "Source not found: $src"
        return 1
    fi

    if [ -L "$dest" ]; then
        # 既存のシンボリックリンクを削除
        rm "$dest"
    elif [ -e "$dest" ]; then
        # 既存ファイルをバックアップ
        local backup="${dest}.backup.$(date +%Y%m%d%H%M%S)"
        warn "Backing up existing file: $dest -> $backup"
        mv "$dest" "$backup"
    fi

    ln -s "$src" "$dest"
    info "Created symlink: $dest -> $src"
}

main() {
    info "Setting up dotfiles..."

    # Zsh設定
    create_symlink "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
    create_symlink "$DOTFILES_DIR/zsh/.gemrc" "$HOME/.gemrc"
    create_symlink "$DOTFILES_DIR/zsh/.zprofile" "$HOME/.zprofile"

    # Git設定
    create_symlink "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"

    # ローカル環境変数ファイルのテンプレート作成
    if [ ! -e "$HOME/.zshenv.local" ]; then
        info "Creating ~/.zshenv.local template..."
        cat > "$HOME/.zshenv.local" << 'EOF'
# Local environment variables (not tracked by git)
# Add your secrets here, e.g.:
# export LINEAR_API_KEY="your-api-key"
EOF
        chmod 600 "$HOME/.zshenv.local"
    fi

    info "Setup complete!"
}

main "$@"
