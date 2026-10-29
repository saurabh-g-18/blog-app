# The Reading Room

## Flutter Blog App — Launcher Icon Notes

### 1. Icon configuration

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

### 2. When to regenerate the icon

Run this only when you change the icon image or its configuration:

```bash
dart run flutter_launcher_icons
```

### 3. Normal development

For ordinary code changes, use:

```bash
flutter run
```

Hot reload and hot restart are normally sufficient for Dart code changes.

### 4. When the launcher icon doesn't update

Run these commands from the project root:

```bash
flutter clean
flutter pub get
flutter run
```

If the old icon remains on the simulator, uninstall the app and run it again.


## App Branding: Name & Launcher Icon

### 1. Renaming the App

#### iOS

Open `ios/Runner/Info.plist` and set:

```xml
<key>CFBundleDisplayName</key>
<string>The Reading Room</string>
```

Keep `CFBundleName` unchanged unless you specifically need to change the internal bundle name.

#### Android

Open `android/app/src/main/AndroidManifest.xml` and update the application label to:

```xml
android:label="The Reading Room"
```

If the manifest uses a string resource such as `@string/app_name`, update the corresponding value in `android/app/src/main/res/values/strings.xml` instead.

### 2. Replacing the App Icon

**Current icon path:** `assets/icons/app_icon.jpeg`

The project uses the `flutter_launcher_icons` package to generate native launcher icons for iOS and Android.

#### Step 1: Replace the icon image

- Replace the existing icon image in `assets/icons/`.
- Keep the filename and format consistent with the `image_path` in `pubspec.yaml`.

For example, the current configuration is:

```yaml
flutter_launcher_icons:
  image_path: "assets/icons/app_icon.jpeg"
  ios: true
  android: true
  remove_alpha_ios: true
```

If the new image is a PNG, update `image_path` to its actual `.png` filename rather than merely renaming the extension.

#### Step 2: Regenerate launcher icons

Run from the project root:

```bash
dart run flutter_launcher_icons
```

Wait for the successful generation message.

#### Step 3: Rebuild the app

```bash
flutter clean
flutter pub get
flutter run
```

If the old icon still appears on the simulator, delete the installed app and reinstall it by running `flutter run` again.


