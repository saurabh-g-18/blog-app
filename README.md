# The Reading Room

# Flutter Blog App — Launcher Icon Notes

## 1. Icon configuration

**Icon image path:** `assets/icons/app_icon.jpeg`

**Package:** `flutter_launcher_icons`

In `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.14.4

flutter_launcher_icons:
  image_path: "assets/icons/app_icon.jpeg"
  android: true
  ios: true
  remove_alpha_ios: true
```

Keep the `flutter_launcher_icons` configuration at the top level of `pubspec.yaml`, aligned with `dependencies` and `dev_dependencies`.

## 2. When to regenerate the icon

Run this only when you change the icon image or its configuration:

```bash
dart run flutter_launcher_icons
```

## 3. Normal development

For ordinary code changes, use:

```bash
flutter run
```

Hot reload and hot restart are normally sufficient for Dart code changes.

## 4. When the launcher icon doesn't update

Run these commands from the project root:

```bash
flutter clean
flutter pub get
flutter run
```

If the old icon remains on the simulator, uninstall the app and run it again.

