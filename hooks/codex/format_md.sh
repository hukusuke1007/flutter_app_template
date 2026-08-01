#!/usr/bin/env bash
# Codex用Markdown整形スクリプト。
# PostToolUseで受け取るapply_patchのパッチから編集対象を抽出し、
# markdownlint --fixの後にPrettierを実行する。
#
# 使い方:
#   1) CLIから明示指定:
#        hooks/codex/format_md.sh <file.md> [<file2.md> ...]
#   2) Codexフックから:
#        標準入力にPostToolUseのJSONを渡す。
#
# フォーマッターが失敗してもCodexの処理を止めない。

set -u

files=()

if [ "$#" -gt 0 ]; then
  files=("$@")
elif [ ! -t 0 ]; then
  hook_input=$(cat)

  while IFS= read -r f; do
    [ -n "$f" ] && files+=("$f")
  done < <(
    jq -r '
      select(.tool_name == "apply_patch")
      | (.tool_input.command? // "")
      | split("\n")[]
      | select(test("^\\*\\*\\* (Add|Update) File: |^\\*\\*\\* Move to: "))
      | sub("^\\*\\*\\* (Add|Update) File: "; "")
      | sub("^\\*\\*\\* Move to: "; "")
    ' <<< "$hook_input" 2>/dev/null
  )
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
