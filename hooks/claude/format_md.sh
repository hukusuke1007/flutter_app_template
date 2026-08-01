#!/usr/bin/env bash
# Markdown整形スクリプト
# markdownlint --fix で自動修正可能なルール違反を直してから、Prettier で整形する。
# VSCodeの source.fixAll(markdownlint) → formatOnSave(prettier) の順序に合わせている。
# （順序を逆にすると、`#見出し` のようにスペース無しの行をprettierが段落として
#  上の行と結合してしまい、markdownlintの修正対象から外れる）
#
# 使い方:
#   1) CLIから明示指定:
#        0_scripts/format_md.sh <file.md> [<file2.md> ...]
#   2) Claude Code フックから:
#        標準入力にPostToolUseのJSONを渡すと .tool_input.file_path を読む
#
# 失敗してもexit 0で抜ける（フックから呼ばれた際に処理を止めないため）。

set -u

files=()

if [ "$#" -gt 0 ]; then
  files=("$@")
elif [ ! -t 0 ]; then
  # stdinがパイプ/リダイレクト → Claude Code フック経由
  f=$(jq -r '.tool_input.file_path // empty' 2>/dev/null)
  [ -n "$f" ] && files=("$f")
fi

[ "${#files[@]}" -eq 0 ] && exit 0

for f in "${files[@]}"; do
  [ -z "$f" ] && continue
  case "$f" in
    *.md|*.MD|*.markdown) ;;
    *) continue ;;
  esac
  [ -f "$f" ] || continue

  markdownlint --fix "$f" >/dev/null 2>&1 || true
  prettier --write "$f" >/dev/null 2>&1 || true
done

exit 0
