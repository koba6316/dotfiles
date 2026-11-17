# dotfiles

macOS 用の個人設定ファイル集。 AI エージェント（Claude Code など）が主なシェル利用者である前提で、**デフォルトは AI 、人間向けの設定は opt-in** にしている。

## インストール

詳細な手順・手動項目・注意点は **[docs/new-mac-setup.md](docs/new-mac-setup.md)** を参照。概要:

```bash
gh repo clone koba6316/dotfiles ~/dotfiles   # 要 gh auth login 。 clone 先は ~/dotfiles 固定
~/dotfiles/setup.sh                          # symlink と *.local 雛形を作成（既存ファイルは .backup.* に退避）
mise bootstrap --dry-run && mise bootstrap   # brew / cask / tap / ツールを config/mise/config.toml から導入
```

パッケージの正本は `config/mise/config.toml`。`Brewfile` は旧方式で内容が古い。

## 構成

```
dotfiles/
├── Brewfile                    # 旧方式（古い。正本は config/mise/config.toml）
├── setup.sh                    # symlink と *.local 雛形の作成スクリプト
├── docs/
│   └── new-mac-setup.md        # 新 Mac セットアップ手順
├── .gitconfig                  # Git 設定（マシン固有は ~/.gitconfig.local）
├── config/
│   ├── mise/config.toml        # ランタイム定義 + bootstrap 宣言（~/.config/mise/）
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
- **ランタイム管理**: mise に一本化（nvm / rbenv / rvm は廃止。 asdf と tfenv は dart / flutter / ruby / terraform 用に当面残している）。`.nvmrc` は読み込まれるが、未導入のバージョンは `mise install` が必要。
- **Flutter**: fvm 。

## 機密情報・マシン固有設定

Git 管理外のファイルに書く。

- `~/.zshenv.local`: API キーなどの環境変数
- `~/.gitconfig.local`: `user.signingkey` の上書きなど

## 前提条件

macOS (Apple Silicon) / Homebrew / Zsh
