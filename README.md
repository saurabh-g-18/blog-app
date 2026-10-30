# The Reading Room

## 🏗️ Project Architecture

![Project Architecture](assets/architecture.png)

## 🛠️ Tech Stack

### Frontend
<p align="left">
  <a href="https://flutter.dev/">
    <img src="https://skillicons.dev/icons?i=flutter" width="48" height="48" alt="Flutter"/>
  </a>
  <a href="https://dart.dev/">
    <img src="https://skillicons.dev/icons?i=dart" width="48" height="48" alt="Dart"/>
  </a>
</p>

### Backend & Database
<p align="left">
  <a href="https://supabase.com/">
    <img src="https://skillicons.dev/icons?i=supabase" width="48" height="48" alt="Supabase"/>
  </a>
  <a href="https://www.postgresql.org/">
    <img src="https://skillicons.dev/icons?i=postgres" width="48" height="48" alt="PostgreSQL"/>
  </a>
  <img src="https://img.shields.io/badge/Hive-Local%20Database-FFC107?style=for-the-badge" alt="Hive"/>
</p>

### State Management & Architecture
<p align="left">
  <img src="https://img.shields.io/badge/Flutter%20BLoC-State%20Management-5B6ABF?style=for-the-badge" alt="Flutter BLoC"/>
  <img src="https://img.shields.io/badge/GetIt-Dependency%20Injection-4B8BBE?style=for-the-badge" alt="GetIt"/>
  <img src="https://img.shields.io/badge/Fpdart-Functional%20Programming-6A5ACD?style=for-the-badge" alt="Fpdart"/>
</p>

### Tools & Version Control
<p align="left">
  <a href="https://git-scm.com/">
    <img src="https://skillicons.dev/icons?i=git" width="48" height="48" alt="Git"/>
  </a>
  <a href="https://github.com/">
    <img src="https://skillicons.dev/icons?i=github" width="48" height="48" alt="GitHub"/>
  </a>
  <a href="https://code.visualstudio.com/">
    <img src="https://skillicons.dev/icons?i=vscode" width="48" height="48" alt="VS Code"/>
  </a>
</p>

### Architecture
- Clean Architecture
- Repository Pattern
- BLoC Pattern
- Dependency Injection

### Storage
- **Supabase Storage:** Cloud-based blog image storage.
- **Hive:** Local NoSQL database for on-device data persistence.


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


## Adding Images to iOS Simulator Gallery

If you want to test image selection functionality in your Flutter app, you can import images into the iOS Simulator's Photos gallery.

### Method 1: Using Drag and Drop

1. Open the iOS Simulator.
2. Open Finder on your Mac.
3. Locate the image you want to import.
4. Drag and drop the image into the Simulator window.
5. Open the Photos app inside the Simulator.
6. Check the Recents album for the imported image.

### Method 2: Using Terminal 

If drag and drop doesn't work, use the following command.

**Import a single image:**

```bash
xcrun simctl addmedia booted ~/Downloads/photo.jpg
```

Replace `photo.jpg` with your actual image filename.

**Import multiple JPG images:**

```bash
xcrun simctl addmedia booted ~/Downloads/*.jpg
```

**Import PNG images:**

```bash
xcrun simctl addmedia booted ~/Downloads/*.png
```

### Verify Imported Images

1. Make sure your iOS Simulator is running.
2. Open the Photos app.
3. Navigate to Recents.
4. Verify that your imported images are visible.

### Troubleshooting

- Ensure the iOS Simulator is running before executing the command.
- Check that the image filename and file path are correct.
- Use `xcrun simctl list devices booted` to check running simulators.
- If multiple simulators are running, specify the target simulator's UDID instead of using `booted`.


