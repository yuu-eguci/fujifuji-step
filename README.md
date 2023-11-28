fujifuji-step
===

😩 🐾 Measuring code quantity through lines of code is unrelated to the actual quality or efficiency of the code, and doesn't reflect its complexity. It can even encourage the addition of unnecessary code, making it easy to artificially inflate the line count, which renders the measurement meaningless. Moreover, comparing between different programming languages becomes difficult, and it doesn't take into account the maintainability or extensibility of the code. It's a ludicrous relic of the past, but it does make for an interesting topic of conversation.

## Usage

```bash
bash ./fujifuji-step.sh [author] [start_date] [end_date] [git_repo_path (optional)]

bash ./fujifuji-step-monthly.sh [author] [start_month] [end_month] [git_repo_path (optional)]
```

## Output example

Fujifuji-step analyzes a specified author's Git commit history over a certain period, outputting daily statistics on lines added and removed.

```
$ bash ./fujifuji-step.sh foo@bar.com 2023-11-01 2023-11-17
2023-11-01 0 (+0, -0)
2023-11-02 14 (+9, -5)
2023-11-03 0 (+0, -0)
2023-11-04 0 (+0, -0)
2023-11-05 0 (+0, -0)
2023-11-06 233 (+121, -112)
2023-11-07 953 (+872, -81)
2023-11-08 137 (+94, -43)
2023-11-09 854 (+425, -429)
2023-11-10 10 (+0, -10)
2023-11-11 0 (+0, -0)
2023-11-12 0 (+0, -0)
2023-11-13 334 (+272, -62)
2023-11-14 321 (+223, -98)
2023-11-15 0 (+0, -0)
2023-11-16 532 (+440, -92)
2023-11-17 691 (+458, -233)
```

Fujifuji-step-monthly analyzes a specified author's Git commit history over a certain period, outputting monthly statistics on lines added and removed.

ステップ数なんてものは馬鹿げた過去の遺物だけど、話のネタにはなるよね。

```
$ bash ./fujifuji-step-monthly.sh foo@bar.com 2023-11-01 2023-11-17
2023-01 0 (+0, -0)
2023-02 0 (+0, -0)
2023-03 0 (+0, -0)
2023-04 0 (+0, -0)
2023-05 0 (+0, -0)
2023-06 0 (+0, -0)
2023-07 0 (+0, -0)
2023-08 13450 (+13430, -20)
2023-09 47 (+43, -4)
2023-10 1319 (+1045, -274)
2023-11 0 (+0, -0)
2023-12 0 (+0, -0)
```
