# memtop

*[Leggi in italiano](README.it.md)*

RAM used **per application** on macOS. Each app is also credited with the system processes it launched (WebContent, VirtualMachine, XPC services…), the way Activity Monitor does.

## What it shows

- **Header**: used RAM computed like Activity Monitor (app + wired + compressed), cache/free/swap breakdown and macOS memory pressure.
- **Table**: for each app, RAM, % of total RAM and number of processes.
- **Footer**: total (GB and %) of the apps shown and how much everything else uses.

## Usage

```
memtop [N]           top N apps (default 15)
memtop -w [N]        refresh every 3 seconds (Ctrl+C to quit)
memtop -d [N]        detail of the processes attributed to each app
memtop -p [N]        raw view, grouped by process name only
memtop --no-color    no colors (also with NO_COLOR=1)
memtop --lang en|it  output language
memtop -h            help
```

## Language

Output is in English by default. For Italian, use `--lang it`, set `MEMTOP_LANG=it`, or run with an Italian locale (`LANG=it_IT.UTF-8`). To make it permanent:

```
echo 'export MEMTOP_LANG=it' >> ~/.zshrc
```

## Install

One command (installs to `~/.local/bin`):

```
curl -fsSL https://raw.githubusercontent.com/masini/memtop/main/install.sh | sh
```

Options: `PREFIX=/other/dir` to change the destination, `MEMTOP_REF=v1.1` for a specific branch or tag. Run the command again to update memtop.

From a local clone:

```
ln -s "$PWD/memtop" ~/.local/bin/memtop
```

Requirements: macOS, zsh, python3.

## Notes

Values are the sum of process RSS: shared memory is counted more than once, so totals are slightly overestimated.
