# 新 Mac セットアップ手順

最終更新: 2026-11-18 / 検証した mise: 2026.10.2

この手順は **Mac を入れ替えるとき**に、自分と AI が迷わないための正本。環境の宣言は `config/mise/config.toml` に集約してある (PR #4) 。

## 先に読む (AI 向け要点)

- **正本は `config/mise/config.toml`**。パッケージ・ cask ・ tap ・ dotfiles の symlink ・ランタイムはすべてここ。`Brewfile` は古く (11 件、実態は 35 件) 、`setup.sh` は symlink と `*.local` 雛形の生成に残してあるだけ。
- **手順 A (推奨) を使う**。手順 B は未検証。
- `curl ... | sh` 系 (Homebrew / mise.run の導入) は**人間が実行する**。 AI の自動モードは拒否される。
- `~/.config/mise/config.toml` はこのリポジトリへの symlink 。編集はリポジトリ側で行い、**反映は即時** (ブランチを切り替えると挙動が変わる) 。
- 変更は `master` に直接コミットしない。ブランチ + PR (個人リポジトリなので `gh` CLI) 。

## 手順 A: setup.sh + mise bootstrap (推奨)

mise の機能は `bootstrap` の `packages` / `dotfiles` / `tools` だけを使う。`--from` / `--adopt` は使わない。

1. Xcode Command Line Tools: `xcode-select --install`
2. Homebrew: <https://brew.sh> の手順で導入する (人間が実行)
3. GitHub 認証とリポジトリ取得
   ```bash
   brew install gh mise
   gh auth login
   gh repo clone koba6316/dotfiles ~/dotfiles   # 必ず ~/dotfiles に置く
   ```
4. symlink と雛形の作成: `~/dotfiles/setup.sh`
   - `~/.zshrc` `~/.zprofile` `~/.zshenv` `~/.gemrc` `~/.gitconfig`、 sheldon / mise の設定を symlink する (既存ファイルは `.backup.*` に退避)
   - `~/.gitconfig.local` と `~/.zshenv.local` の雛形を権限 600 で作る (中身は手順 6 で埋める)
5. 宣言の適用
   ```bash
   mise bootstrap --dry-run   # 内容を確認する
   mise bootstrap             # brew 32 件 + cask 3 件 + tap + macOS 設定 + ツールを導入
   ```
   - macOS 設定は Finder の隠しファイル表示 (`AppleShowAllFiles`) 。適用後に `post-defaults` フックで Finder が再起動する (bootstrap のたびに実行される) 。
   - 途中で失敗してもロールバックされない。原因を直して再実行すればよい (宣言部分は冪等) 。
6. 手動で行うもの (下表) を済ませ、新しいシェルを開く
7. 「完了確認」を実行する

### 手動で行うもの (mise が扱わない)

| 項目 | 手順 |
|---|---|
| `~/.gitconfig.local` | `user.signingkey` など (機密のため Git 管理外) |
| `~/.zshenv.local` | API キー (`LINEAR_API_KEY` など) 。 mise の secrets は環境変数を読むだけで保管庫ではない |
| SSH 鍵 | 別途用意する |
| Python 3.13 | python.org のインストーラで導入する。`.zprofile` の PATH と `PYTHON_BIN=/usr/local/bin/python3.13` (banner-creative 用) が前提にしている。先に入れないと PATH とパスが空振りする |
| `xurl` (cask) | `brew trust xdevplatform/tap && brew install --cask xdevplatform/tap/xurl` (未信頼 tap 由来で mise は 404) |
| App Store アプリ | mise は `mas` 非対応。入れていたものを手動で再導入する (一覧は未棚卸し) |
| terraform | `tfenv install 0.13.7 0.14.11 1.15.8` し、既定を `0.13.7` にする (旧環境の構成。`WorkSpace/terraform/.terraform-version` あり) |
| dart / flutter / ruby | asdf のプラグインを入れ、各プロジェクトの `.tool-versions` に従って `asdf install` |
| gcloud / AWS | `gcloud auth login`、 AWS の認証設定 (aws-vault) |

## 手順 B: `--from` + `--config-dir` (将来・未検証)

公式ドキュメントの記述だけが根拠で、**実行では確認できていない**。検証時の mise 2026.10.2 は `--config-dir` を持たず、実行できなかった。

```bash
curl -fsSL https://mise.run | sh            # 人間が実行。~/.local/bin に入る
mise bootstrap --from https://github.com/koba6316/dotfiles.git \
  --from-dir ~/dotfiles --config-dir config/mise
```

- `--from-dir ~/dotfiles` は必須。`[dotfiles]` の source が `~/dotfiles/...` 固定のため。
- **`--adopt` は使えない**。リポジトリ全体を `~/.config/mise` に clone する方式 (dry-run で `git clone <repo> ~/.config/mise` と出ることを確認済み) 。`config.toml` がリポジトリのルートにある構成向けで、このリポジトリ (`config/mise/`) とは合わない。
- `mise.run` の mise と `brew:mise` で mise が二重に入る。 PATH の優先順を決めること。
- 非公開リポジトリは先に GitHub 認証が要る (`mise exec gh@latest -- gh auth login --hostname github.com --git-protocol https --web`) 。

## 完了確認

```bash
mise doctor                      # 問題なし (更新通知のみ可)
mise bootstrap --dry-run         # 差分ゼロ
mise current node                # 22.14.0
ls -la ~/.zshrc ~/.zprofile ~/.zshenv ~/.gemrc ~/.gitconfig \
  ~/.config/sheldon/plugins.toml ~/.config/mise/config.toml   # すべて ~/dotfiles を指す
echo $PYTHON_BIN && test -x "$PYTHON_BIN" && echo ok
```

## やってはいけないこと

- **`mise bootstrap packages prune` を使わない**。`fvm` の receipt が旧 tap のままで、 mise が Ruby 3 を要求して失敗する。`brew reinstall fvm` で receipt を直し、`prune --dry-run` で確認してから。
- **`[bootstrap.mise_shell_activate]` を有効にしない**。`.zshrc` の `eval "$(mise activate zsh)"` と `.zshenv` / `.zprofile` の shim PATH があり、二重になる。
- **clone 先を `~/dotfiles` 以外にしない**。`[dotfiles]` の source が `~/dotfiles/...` で書いてある。
- **`Brewfile` を正本にしない**。`brew bundle` で入れても不完全な環境になる。
- **`brew:` に版は指定できない** (`latest` 固定) 。

## 判断の記録

詳細は PR #4 と `config/mise/config.toml` のコメントを参照。

| 対象 | 判断 | 理由 |
|---|---|---|
| `tfenv` / `asdf` | 宣言して残す | 使用中 (terraform 3 版、 dart/flutter/ruby) 。 mise への移行は別タスク |
| `nvm` / `pipx` | 外した | 未使用 / 空 |
| `python@3.14` / `libyaml` / `pcre2` | 外した | 依存のみ。 brew が解決する |
| `fvm` の tap | 不要 | homebrew/core 由来 |
| `xurl` / `mas` | 宣言しない | mise が非対応 |

## 未検証 / TODO (Mac を入れ替えるときに確認する)

- [ ] **手順 A の通し実行** (新しい Mac での初回。これまでは今のマシンでの dry-run のみ)
- [ ] `brew upgrade mise` の後、偽 HOME で手順 B を dry-run 検証する
  ```bash
  env HOME=$(mktemp -d) mise bootstrap --from file://$HOME/dotfiles \
    --from-dir <偽 HOME>/dotfiles --config-dir config/mise --dry-run
  ```
- [ ] `*.local` 雛形の生成を `[tasks.bootstrap]` に移す (冪等に。移したら `setup.sh` と `Brewfile` を別 PR で廃止)
- [ ] `brew reinstall fvm` の後に `prune --dry-run` を再確認する
- [ ] tfenv → mise の terraform 、 asdf → mise への移行 (別タスク)
- [ ] App Store アプリと `xurl` の棚卸し

## 参考 (公式)

- <https://mise.jdx.dev/bootstrap.html>
- <https://mise.jdx.dev/bootstrap/setup.html>
- <https://mise.jdx.dev/bootstrap/from-repository.html>
- <https://mise.jdx.dev/dotfiles/managed.html>
