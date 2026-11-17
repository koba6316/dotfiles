# dotfiles (AI 向け作業ガイド)

macOS 用の個人設定ファイル集。構成は `README.md`、新 Mac の手順は `docs/new-mac-setup.md` を参照。

## 最重要: このリポジトリは実環境に直結している

- `~/.zshrc` `~/.zprofile` `~/.zshenv` `~/.gemrc` `~/.gitconfig` `~/.config/mise/config.toml` `~/.config/sheldon/plugins.toml` は、このリポジトリのファイルへの **symlink**。
- 作業ツリーの編集とブランチ切替は**そのまま実環境に反映される**。編集前に必ずブランチを確認する。
- デフォルトブランチは `master`。直接編集せず、ブランチ + PR で変更する (個人リポジトリなので `gh` CLI を使う) 。

## 守ること

- **パッケージ・ツール宣言の正本は `config/mise/config.toml`**。`Brewfile` は旧方式で古いため、正本として扱わない。
- 変更後は `mise bootstrap --dry-run` で差分を確認する。`mise bootstrap` の本実行は人間の確認を得てから。
- `mise bootstrap packages prune` は使わない (`fvm` の receipt が旧 tap で失敗する。詳細は `docs/new-mac-setup.md`) 。
- `[bootstrap.mise_shell_activate]` は有効にしない (`.zshrc` の `mise activate` と二重になる) 。
- このリポジトリの clone 先は `~/dotfiles` 固定 (`[dotfiles]` の source がこのパスで書かれている) 。
- `*.local` (`~/.zshenv.local` `~/.gitconfig.local`) は機密のため触らない・コミットしない。
- `.zshenv` の `is_human()` により、 AI シェルは `.zshrc` を早期 return する。`.zshrc` に AI でも必要な設定を書かない (共有環境変数は `.zshenv`) 。
- `curl ... | sh` 系の導入スクリプトは AI が実行せず、人間に依頼する。

## Mac 入れ替え時

`docs/new-mac-setup.md` の手順 A を実行し、末尾の「未検証 / TODO 」を**消化のルールに従って上から順に確認する**。確認結果は同ファイルに反映する PR を出す (確認できなかった項目は理由を添えて残す) 。
