# Workday Music Tracker

## Music Tracker

Automatically tracks songs played in Apple Music while working and logs them to daily files. At the end of the week, generate a playlist to share with people.

### How it works

A macOS launchd agent runs `track-music.py` automatically at login and keeps it running in the background. Every 60 seconds the script uses AppleScript to ask Music.app what's currently playing. If the song has changed since the last check, it appends a new entry to that day's log file — so each song is only recorded once no matter how long it plays.

Logs are stored as newline-delimited JSON (one entry per line) at:
```
~/Storage/notes/sessions/YYYY-MM-DD/music.jsonl
```

Each entry looks like:
```json
{"title": "Alabama", "artist": "Neil Young", "album": "Harvest", "first_heard_at": "2026-04-17T20:13:22+00:00"}
```

At the end of the week, `weekly-playlist` reads all the daily logs from Monday to today, deduplicates across days, and prints a clean numbered playlist you can share with anyone.

If you use Claude Code's `/session-notes` skill, it will also automatically pull today's log and include a **Listening** section in your notes.

### Setup (new machine)

```bash
git clone https://github.com/hawbra56/workday-music-tracker
cd workday-music-tracker
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
