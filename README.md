# dotfiles

macOS 用の個人設定ファイル集。 AI エージェント（Claude Code など）が主なシェル利用者である前提で、**デフォルトは AI 、人間向けの設定は opt-in** にしている。

## インストール

```bash
git clone https://github.com/koba6316/dotfiles.git ~/dotfiles
cd ~/dotfiles
brew bundle --file=Brewfile   # sheldon / mise などを導入
./setup.sh                    # symlink を作成（既存ファイルは .backup.* に退避）
```

## 構成

```
dotfiles/
├── Brewfile                    # 導入するツール
├── setup.sh                    # symlink 作成スクリプト
├── .gitconfig                  # Git 設定（マシン固有は ~/.gitconfig.local）
├── config/
│   ├── mise/config.toml        # ランタイム定義（~/.config/mise/）
│   └── sheldon/plugins.toml    # zsh プラグイン定義（~/.config/sheldon/）
└── zsh/
    ├── .zshenv                 # 全シェル: is_human 判定・共有環境変数
    ├── .zprofile               # ログイン: PATH ・環境変数
    ├── .zshrc                  # 人間の対話シェル専用
    └── .gemrc
```

## AI / 人間の出し分け

`.zshenv` の `is_human()` が、 TTY があり、かつ `AI_AGENT` / `CLAUDECODE` 等がないときだけ人間と判定する。

| | AI シェル | 人間シェル |
|---|---|---|
| `.zshrc` | 早期 return（起動 約 0.02 秒） | プラグイン・補完・プロンプトを読む |
| `EDITOR` / `PAGER` | `true` / `cat`（対話を避ける） | 通常 |
| ランタイム | mise の shim を PATH に置く | `mise activate zsh` |

## ツール

- **プラグイン管理**: Sheldon（`zsh-defer` で遅延ロード）。 oh-my-zsh は使わず、 git / z / extract だけ個別に取得する。
- **ランタイム管理**: mise に一本化（nvm / rbenv / rvm / asdf は廃止）。`.nvmrc` は読み込まれるが、未導入のバージョンは `mise install` が必要。
- **Flutter**: fvm 。

## 機密情報・マシン固有設定

Git 管理外のファイルに書く。

- `~/.zshenv.local`: API キーなどの環境変数
- `~/.gitconfig.local`: `user.signingkey` の上書きなど

## 前提条件

macOS (Apple Silicon) / Homebrew / Zsh
