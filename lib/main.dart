import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

// Initialize the plugin
final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup notifications
  await setupNotifications();

  // Request notification permissions (Android 13+ & iOS)
  await requestNotificationPermission();
  runApp(const MyApp());
}

// Configure notifications
Future<void> setupNotifications() async {
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher'); // Default app icon

  const DarwinInitializationSettings iosSettings =
      DarwinInitializationSettings();

  await notificationsPlugin.initialize(
    const InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    ),
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      // Handle notification tap
      if (response.payload != null) {
        print("Notification tapped with payload: ${response.payload}");
      }
    },
  );
}

// Show a simple notification
Future<void> showSimpleNotification() async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'basic_channel', // Channel ID
    'Basic Notifications', // Channel name
    importance: Importance.defaultImportance,
    priority: Priority.defaultPriority,
  );

  const NotificationDetails platformDetails = NotificationDetails(
    android: androidDetails,
    iOS: DarwinNotificationDetails(),
  );

  await notificationsPlugin.show(
    0, // Notification ID (must be unique)
    'Hello!', // Title
    'This is a simple local notification', // Body
    platformDetails,
    payload: 'notification_payload', // Optional data
  );
}

// Request permissions
Future<void> requestNotificationPermission() async {
  await Permission.notification.request(); // Android 13+

  // iOS permissions
  await notificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
}
// Show big picture notification
Future<void> showBigPictureNotification() async {
  final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'big_picture_channel', // Channel ID
    'Big Picture Notifications', // Channel Name
    channelDescription: 'Notifications with expanded image view',
    importance: Importance.high,
    priority: Priority.high,
    styleInformation: BigPictureStyleInformation(
      // Uses your default app icon as the big picture
      const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      contentTitle: 'Expanded Title', // Appears when expanded
      summaryText: 'More details here', // Appears below image
    ),
  );

  final NotificationDetails platformDetails = NotificationDetails(
    android: androidDetails,
    // Keep iOS simple (won't show big picture)
    iOS: const DarwinNotificationDetails(),
  );

  await notificationsPlugin.show(
    2, // Notification ID
    'Big Picture Style', // Title (collapsed view)
    'Tap to expand', // Body (collapsed view)
    platformDetails,
  );
}

// Main App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Local Notifications')),
        body: Center(
          child: ElevatedButton(
            onPressed: showBigPictureNotification,
            child: const Text('Show Notification'),
          ),
        ),
      ),
    );
  }
}
