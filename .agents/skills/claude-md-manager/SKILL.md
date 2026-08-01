---
name: claude-md-manager
description: "AGENTS.md / CLAUDE.mdの作成・編集・整理を行うスキル。CLAUDE.mdを50行以下を推奨とし、詳細ルールはrules/やスキルにモジュール化して分割管理する。以下のリクエストで使用する: (1)「CLAUDE.mdを作って」「AGENTS.mdを整理して」などCLAUDE.mdの新規作成・編集、(2)「ルールを追加して」「rules/に分割して」などルールの追加・分離、(3)「ディレクトリ構成を更新して」など参照の更新、(4) 新しいディレクトリやルールファイルを作成した後のCLAUDE.md反映。"
license: MIT
author: shohei
version: 1.0.0
---

# CLAUDE.md Manager

AGENTS.md / CLAUDE.mdをモジュール化して分割管理するためのスキル。

実体は `AGENTS.md` 側に置き、`CLAUDE.md` は `AGENTS.md` へのシンボリックリンクとして設定する。理由は、Claude Code 以外の Codex などのAIエージェントも同じ指示内容を共通で参照できるようにするため（`AGENTS.md` は複数AIツールで共通利用される標準ファイル名）。

## 基本原則

- AGENTS.md / CLAUDE.mdは50行以下を推奨（公式は200行以下）。詳細は `rules/` やスキルにモジュール化して分割する
- CLAUDE.mdにはパスと目的の参照のみ記載する

## CLAUDE.mdの構成

以下のセクションを必要に応じて含める。

1. タイトル・概要（1〜2行）
2. ディレクトリ構成（サブディレクトリがあれば）
3. ルール（参照リンク）
4. その他、そのディレクトリ固有の設定

## 記載フォーマット

### ディレクトリ構成セクション

```markdown
## ディレクトリ構成

- `ディレクトリ名/` — 責務の説明。どういう時に使うか
```

例:

```markdown
- `docs/` — 外部参考資料。ガイドライン参照や資料確認時に使う
- `rules/` — 投稿パターン・記事ルール・日々のルーティン
- `posts/` — 投稿の下書き・記録（日付フォルダで管理）
```

単体ファイルも同じ形式:

```markdown
- `ME.md` — 代表者・会社プロフィール。自己紹介が必要な時に参照する
```

### ルールセクション

```markdown
## ルール

- `rules/ファイル名.md` — そのルールの目的
```

例:

```markdown
- `rules/post_patterns.md` — 投稿パターン集・禁止表現・作成ルール
- `rules/writing_rules.md` — 文章の書き方ルール
```

## ワークフロー

### CLAUDE.mdの新規作成

1. そのディレクトリの責務を1〜2行で記述する
2. サブディレクトリがあれば「ディレクトリ構成」セクションを追加する
3. rules/ があれば「ルール」セクションを追加する
4. 50行以下を推奨。超える場合はモジュール化を検討する

### ルール追加時

1. 詳細なルールは `rules/ファイル名.md` に書く
2. CLAUDE.mdの「ルール」セクションに `ファイルパス` — 目的 の1行を追加する
3. CLAUDE.mdに詳細を直接書かない

### 行数超過時の対処

1. 詳細な説明を `rules/` に切り出す
2. CLAUDE.mdには参照リンクのみ残す
3. 重複する記述を統合する

### 新しいルールファイルやディレクトリを作成した時

1. そのディレクトリの CLAUDE.md に `パス` — 説明 の1行を追加する
2. ルートの AGENTS.md にも反映が必要か確認し、必要なら追加する
   - 新しいトップレベルディレクトリ → AGENTS.md の「ディレクトリ構成」に追加
   - サブディレクトリやルールファイル → 該当ディレクトリの CLAUDE.md に追加

## 参考資料

- <https://code.claude.com/docs/en/memory> — Claude Code公式ドキュメント（200行以下推奨、`@path` インポート、`.claude/rules/` 分割）
- <https://addyosmani.com/blog/agents-md/> — 階層型アーキテクチャ、`rules/` 分割、最小限の記述を推奨
- <https://www.humanlayer.dev/blog/writing-a-good-claude-md> — 300行未満推奨、ファイル参照によるモジュール化
- <https://nyosegawa.com/posts/harness-engineering-best-practices-2026/> — 50行以下推奨、モジュール分割、削減基準の解説

## 注意事項

- CLAUDE.mdに詳細なルールや手順を直接書かない
- 「`パス` — 説明」の形式を必ず守る
- ルートのAGENTS.mdには「作業前に対応ディレクトリのCLAUDE.mdとrules/を必ず読むこと」と明記する
- 新しいファイルやディレクトリを作成したら、必ず対応するCLAUDE.md / AGENTS.mdを更新する
