#!/bin/bash

# このスクリプトは、指定された作者の Git コミット履歴を特定の期間にわたって分析し、
# 日ごとに追加された行数と削除された行数の統計を出力します。
# 使用方法:
#   bash ./fujifuji-step.sh [author] [start_date] [end_date] [git_repo_path（オプショナル）]
# ここで、[author] はコミットの作者、[start_date] と [end_date] は YYYY-MM-DD 形式の日付です。
# [git_repo_path] は Git リポジトリのパスで、指定されていない場合はカレントディレクトリが使用されます。

# コマンドライン引数の確認
if [ "$#" -lt 3 ]; then
    echo "Usage: $0 author start_date end_date [git_repo_path]"
    exit 1
fi

author=$1
start_date=$2
end_date=$3
git_repo_path=${4:-.}  # デフォルトはカレントディレクトリ

# Linux 用
# increment_date() {
#     date -I -d "$1 +1 day"
# }
# 日付を YYY-MM-DD 形式で増やす関数（macOS 用）
increment_date() {
    date -j -v+1d -f "%Y-%m-%d" "$1" "+%Y-%m-%d"
}

current_date="$start_date"
cd "$git_repo_path" || exit  # リポジトリへ移動、失敗したら終了
until [[ $current_date > $end_date ]]; do
    since="$current_date"T00:00:00
    until_date=$(increment_date "$current_date")T00:00:00
    result=$(git log --numstat --pretty="%H" --author="$author" --since="$since" --until="$until_date" --no-merges | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("%d (+%d, -%d)\n", plus+minus, plus, minus)}')
    echo "$current_date $result"
    current_date=$(increment_date "$current_date")
done
