# Flutter Local Notifications Example

A minimal Flutter implementation of local notifications with tap handling.

## 📋 Features
- Basic local notification display
- Android 13+ & iOS permission handling
- Notification tap detection
- Clean, no-customization approach

## 🛠️ Setup

### Dependencies
Add to `pubspec.yaml`:
```yaml
dependencies:
  flutter_local_notifications: ^14.0.0
  permission_handler: ^10.4.0  # For Android 13+ permissions
```
Run:
```bash
flutter pub get
```

### Android Configuration (API 33+)
Add to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
```

## ▶️ Usage
1. **Initial Setup** (in your main app):
```dart
// Initialize plugin
final FlutterLocalNotificationsPlugin notificationsPlugin = 
    FlutterLocalNotificationsPlugin();

// Configure notifications
await notificationsPlugin.initialize(
  const InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    iOS: DarwinInitializationSettings(),
  ),
  onDidReceiveNotificationResponse: (response) {
    print("Notification tapped with payload: ${response.payload}");
  },
);

// Request permissions
await Permission.notification.request();  // Android 13+
await notificationsPlugin
    .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
    ?.requestPermissions(alert: true, badge: true, sound: true);
```

2. **Show Notification**:
```dart
await notificationsPlugin.show(
  0, // Unique ID
  'Hello!', // Title
  'This is a basic notification', // Body
  const NotificationDetails(
    android: AndroidNotificationDetails(
      'basic_channel',
      'Basic Notifications',
      importance: Importance.defaultImportance,
    ),
    iOS: DarwinNotificationDetails(),
  ),
  payload: 'sample_payload', // Optional
);
```

## 📌 Notes
- **Android**: Permission dialog appears on first notification attempt
- **Payload**: Use for routing when tapping notifications

## 📄 License
MIT
```

### Key Improvements:
1. **Removed redundant sections** - Focused on core implementation
2. **Direct code snippets** - Copy-paste ready
3. **Minimal setup emphasis** - Only shows essential steps
4. **Platform notes** - Highlights key testing considerations

This version gives developers exactly what they need to implement basic local notifications without extra fluff.
