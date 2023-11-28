#!/bin/bash

# このスクリプトは、指定された作者の Git コミット履歴を特定の期間にわたって分析し、
# 月ごとに追加された行数と削除された行数の統計を出力します。
# 使用方法:
#   bash ./fujifuji-step-monthly.sh [author] [start_month] [end_month] [git_repo_path（オプショナル）]
# ここで、[author] はコミットの作者、[start_month] と [end_month] は YYYY-MM 形式の月です。
# [git_repo_path] は Git リポジトリのパスで、指定されていない場合はカレントディレクトリが使用されます。

# コマンドライン引数の確認
if [ "$#" -lt 3 ]; then
    echo "Usage: $0 author start_month end_month [git_repo_path]"
    exit 1
fi

author=$1
start_month=$2
end_month=$3
git_repo_path=${4:-.}  # デフォルトはカレントディレクトリ

# 日付を YYYY-MM 形式で増やす関数（macOS 用）
increment_month() {
    date -j -v+1m -f "%Y-%m" "$1" "+%Y-%m"
}

current_month="$start_month"
cd "$git_repo_path" || exit  # リポジトリへ移動、失敗したら終了
until [[ $current_month > $end_month ]]; do
    since="$current_month"-01T00:00:00
    until_month=$(increment_month "$current_month")
    until_date="$until_month"-01T00:00:00
    result=$(git log --numstat --pretty="%H" --author="$author" --since="$since" --until="$until_date" --no-merges | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("%d (+%d, -%d)\n", plus+minus, plus, minus)}')
    echo "$current_month $result"
    current_month=$(increment_month "$current_month")
done
