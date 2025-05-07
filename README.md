# 📱 Flutter Local Notifications  
**A Beautiful Guide to Basic and Custom Notifications**  

---

## 🌟 **Features**  
✅ Basic text notifications  
🎨 Custom Big Picture style (using app icon)  
📱 Works on Android & iOS  
🔔 Tap-to-open functionality  

---

# 🛠 **Setup Guide**  

### 1. **Add Dependencies**  
```yaml
dependencies:
  flutter_local_notifications: ^14.0.0
  permission_handler: ^10.4.0  # For Android 13+
```

Run:  
```bash
flutter pub get
```

---

### 2. **Android Configuration** *(Optional for API 33+)*  
Add to `android/app/src/main/AndroidManifest.xml`:  
```xml
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
```

---

### 3. **Initialize Notifications**  
Add to your `main.dart`:  
```dart
final FlutterLocalNotificationsPlugin notificationsPlugin = 
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Basic setup
  const AndroidInitializationSettings androidSettings = 
      AndroidInitializationSettings('@mipmap/ic_launcher');
  
  await notificationsPlugin.initialize(
    const InitializationSettings(
      android: androidSettings,
      iOS: DarwinInitializationSettings(),
    ),
    onDidReceiveNotificationResponse: (response) {
      print('Notification tapped!');
    },
  );
  
  runApp(MyApp());
}
```

# 🔹 **Basic Notification**  
**Simple text alert**  

```dart
Future<void> showBasicNotification() async {
  const AndroidNotificationDetails androidDetails = 
      AndroidNotificationDetails(
    'basic_channel', 
    'General Notifications',
    importance: Importance.defaultImportance,
  );

  await notificationsPlugin.show(
    0, 
    'Hello 👋', 
    'This is a basic Flutter notification',
    const NotificationDetails(android: androidDetails),
  );
}
```

**Output**:  
![Screenshot_20250507-175919_1](https://github.com/user-attachments/assets/536d1d2d-6958-4bf0-b5e6-29d91424b592)


---

# 🎨 **Custom Big Picture Notification**  
**Expanded view with app icon**  

```dart
Future<void> showBigPictureNotification() async {
  final AndroidNotificationDetails androidDetails = 
      AndroidNotificationDetails(
    'big_picture_channel',
![Screenshot_20250507-175919_1](https://github.com/user-attachments/assets/d894f66e-8537-4e2d-a4fd-8df4778f9438)
    'Rich Notifications',
    styleInformation: BigPictureStyleInformation(
      const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      contentTitle: 'Expanded Title',
      summaryText: 'More context here',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    ),
  );

  await notificationsPlugin.show(
    1,
    'New Alert!', 
    'Tap to expand →',
    NotificationDetails(android: androidDetails),
  );
}
```

**Output**:  

![Screenshot_20250507-185644_1](https://github.com/user-attachments/assets/bedbe843-c592-4c23-893a-f59345a9c917)

---

# 🏃 **Run It!**  
Add buttons to trigger notifications:  
```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    ElevatedButton(
      onPressed: showBasicNotification,
      child: Text('Basic Notification'),
    ),
    SizedBox(height: 20),
    ElevatedButton(
      onPressed: showBigPictureNotification,
      child: Text('Big Picture Notification'),
    ),
  ],
)
```

---

# ⚠️ **Troubleshooting**  
| Issue | Fix |
|-------|-----|
| Notifications not showing | Check `AndroidManifest` permissions |
| No sound/vibration | Verify `importance: Importance.high` |
| iOS not working | Call `requestPermissions()` |

---

### 📝 **Pro Tip**  
For custom images, replace:  
```dart 
DrawableResourceAndroidBitmap('@mipmap/ic_launcher')
```  
with:  
```dart
FilePathAndroidBitmap('assets/custom_image.jpg')
```

---

This README provides:  
✨ **Clean visual hierarchy**  
📝 **Copy-paste-friendly code**  
📱 **Real-device tested examples**  
🎨 **Professional formatting**  

