# dotfiles

Personal scripts and configs for my Mac setup.

---

## Music Tracker

Automatically tracks songs played in Apple Music while working and logs them to daily files. At the end of the week, generate a playlist to share with people.

### How it works

- A background process polls Apple Music every 60 seconds
- New songs are logged to `~/Storage/notes/sessions/YYYY-MM-DD/music.jsonl`
- Session notes automatically include the day's listening history
- Run `weekly-playlist` at any time to see the week's songs

### Setup (new machine)

```bash
git clone https://github.com/hawbra56/dotfiles
cd dotfiles
./install.sh
```

That's it. The tracker starts immediately and runs on every login automatically.

### Commands

| Command | Description |
|---|---|
| `~/bin/music-tracker start` | Start the tracker |
| `~/bin/music-tracker stop` | Stop the tracker |
| `~/bin/music-tracker status` | Check if it's running |
| `~/bin/weekly-playlist` | Print this week's playlist |

### Files

| File | Description |
|---|---|
| `bin/track-music.py` | Background polling script |
| `bin/music-tracker` | Start/stop/status helper |
| `bin/weekly-playlist` | Weekly playlist generator |
| `launchagents/com.bradleyhawkins.track-music.plist` | macOS launchd agent (auto-starts on login) |
| `install.sh` | One-command setup script |
