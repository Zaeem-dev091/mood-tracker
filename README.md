# Mood Tracker

A Flutter web app where you can log how you're feeling throughout the day and see your last 7 entries in a scrollable timeline.

## What it does

Tap one of the five mood faces to log your mood instantly. Each face is drawn entirely with Flutter's `CustomPainter` — no emojis, no images, just canvas drawing primitives. Your recent entries show up in a horizontal timeline at the bottom, and tapping any entry animates it.

## Running locally

```bash
flutter pub get
flutter run -d chrome
```

## State management

I used Provider with a single `ChangeNotifier` class (`MoodProvider`). It holds the list of entries and exposes a `recentEntries` getter that returns the last 7 sorted by date. Widgets listen with `Consumer<MoodProvider>` and rebuild whenever `notifyListeners()` is called. I kept it simple on purpose — the app only has one screen and one piece of shared state, so anything heavier would've been overkill.

## CustomPainter faces

All five expressions are drawn in `MoodFacePainter` using `drawCircle` for the face and eyes, `drawArc` for smiles and frowns, and `drawPath` for the teardrop and open grin. The eyebrows are what really differentiate them — flat for neutral, inner corners raised for sad, angled inward for anxious. Everything scales relative to the widget size so the faces look the same at any size.

## What I'd improve

The entries don't survive a page refresh right now since everything is in memory. I'd add `shared_preferences` to persist them locally. I'd also replace the insight strip at the top with a small bar chart drawn in `CustomPainter` showing mood frequency across the week.

## Deploying

```bash
flutter build web --release
firebase deploy --only hosting
```