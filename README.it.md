# memtop

*[Read in English](README.md)*

RAM occupata **per applicazione** su macOS, attribuendo a ogni app anche i processi di sistema che ha lanciato (WebContent, VirtualMachine, servizi XPC…), come fa Monitoraggio Attività.

## Cosa mostra

- **In alto**: RAM usata calcolata come Monitoraggio Attività (app + wired + compressa), dettaglio cache/libera/swap e livello di pressione di macOS.
- **Tabella**: per ogni app RAM, % sulla RAM totale e numero di processi.
- **In fondo**: totale (GB e %) delle app mostrate e quanto occupa tutto il resto.

## Uso

```
memtop [N]          prime N app (default 15)
memtop -w [N]       aggiorna ogni 3 secondi (Ctrl+C per uscire)
memtop -d [N]       dettaglio dei processi attribuiti a ogni app
memtop -p [N]       vista grezza, raggruppata solo per nome
memtop --no-color   senza colori (anche con NO_COLOR=1)
memtop --lang en|it lingua dell'output
memtop -h           aiuto
```

## Lingua

L'output è in inglese di default. Per l'italiano usa `--lang it`, imposta `MEMTOP_LANG=it` oppure un locale italiano (`LANG=it_IT.UTF-8`). Per renderlo permanente:

```
echo 'export MEMTOP_LANG=it' >> ~/.zshrc
```

## Installazione

Con un comando (installa in `~/.local/bin`):

```
curl -fsSL https://raw.githubusercontent.com/masini/memtop/main/install.sh | sh
```

Opzioni: `PREFIX=/altra/cartella` per cambiare destinazione, `MEMTOP_REF=v1.1`
per un branch o tag specifico. Rilanciare il comando aggiorna memtop.

Da una copia locale del repo:

```
ln -s "$PWD/memtop" ~/.local/bin/memtop
```

Requisiti: macOS, zsh, python3.

## Note

I valori sono la somma dell'RSS dei processi: la memoria condivisa viene contata più volte, quindi i totali sono leggermente sovrastimati.
