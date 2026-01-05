# dotfiles

macOS 用の個人設定ファイル集。

## インストール

```bash
# リポジトリをクローン
git clone https://github.com/koba6316/dotfiles.git ~/dotfiles

# Antigen をインストール（未インストールの場合）
git clone https://github.com/zsh-users/antigen.git ~/antigen

# セットアップ実行
cd ~/dotfiles
./setup.sh
```

## 構成

```
dotfiles/
├── .gitconfig      # Git 設定（エイリアス、diff-so-fancy）
├── .gitignore      # dotfiles 用 gitignore
├── setup.sh        # セットアップスクリプト
├── README.md
└── zsh/
    ├── .zprofile   # ログイン時設定（環境変数、PATH）
    ├── .zshrc      # シェル起動時設定（プラグイン、エイリアス）
    └── .gemrc      # Ruby gem 設定
```

## 機能

### Zsh プラグイン（Antigen 経由）

| プラグイン | 機能 |
|-----------|------|
| git | `gst`, `gco`, `gp` 等のエイリアス |
| z | `z dirname` でディレクトリ高速移動 |
| docker / docker-compose | コンテナ関連の補完 |
| node / npm / yarn | Node.js エコシステムの補完 |
| brew | Homebrew 補完 |
| vscode | `code .` で VS Code 起動 |
| ssh-agent | SSH エージェント自動起動 |
| extract | `extract file.tar.gz` で何でも展開 |
| copypath / copyfile | クリップボード連携 |
| zsh-autosuggestions | コマンド候補をグレー表示（→ で補完） |
| zsh-syntax-highlighting | コマンドの色分け |

### Git エイリアス

```bash
git st          # status
git co          # checkout
git br          # branch
git ci          # commit -a
git pl          # pull
git ps          # push
git cod         # checkout develop
git com         # checkout master
```

### バージョン管理ツール

以下のツールに対応（インストール済みの場合のみ有効化）:

- nvm (Node.js)
- rbenv / rvm (Ruby)
- asdf
- mise
- fvm (Flutter)

## 機密情報の管理

API キーなどの機密情報は `~/.zshenv.local` に記述してください（Git 管理外）。

```bash
# ~/.zshenv.local
export LINEAR_API_KEY="your-api-key"
export GITHUB_TOKEN="your-token"
```

## 前提条件

- macOS (Apple Silicon)
- Homebrew
- Zsh（macOS デフォルト）

## カスタマイズ

ローカル固有の設定は `~/.zshenv.local` に追加することで、Git 管理外で設定できます。
