#!/usr/bin/env python3
import subprocess
import json
import time
from datetime import datetime, timezone
from pathlib import Path

LOG_BASE = Path.home() / "Storage/notes/sessions"
last_track = None


def get_current_track():
    script = """
    tell application "Music"
        if player state is playing then
            set t to current track
            return name of t & "\t" & artist of t & "\t" & album of t
        end if
    end tell
    """
    result = subprocess.run(["osascript", "-e", script], capture_output=True, text=True)
    output = result.stdout.strip()
    if not output:
        return None
    parts = output.split("\t")
    if len(parts) >= 3:
        return {"title": parts[0], "artist": parts[1], "album": parts[2]}
    return None


def log_track(track):
    today = datetime.now().strftime("%Y-%m-%d")
    log_dir = LOG_BASE / today
    log_dir.mkdir(parents=True, exist_ok=True)
    entry = {**track, "first_heard_at": datetime.now(timezone.utc).isoformat()}
    with open(log_dir / "music.jsonl", "a") as f:
        f.write(json.dumps(entry) + "\n")


while True:
    track = get_current_track()
    if track and track != last_track:
        log_track(track)
        last_track = track
    time.sleep(60)
