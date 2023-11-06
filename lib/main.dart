import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:telemed/Providers/telemedDataProvider.dart';
import 'package:telemed/UI/Home/BasePage.dart';
import 'package:telemed/UI/Home/BookAppointmentPage.dart';
import 'package:telemed/UI/Home/BookAppointmentsReasonForVisitPage.dart';
import 'package:telemed/UI/Home/CadersPage.dart';
import 'package:telemed/UI/Home/HealthProfilePage.dart';
import 'package:telemed/UI/Home/Messages/MessagesPage.dart';
import 'package:telemed/UI/Home/Messages/VideoCallPage.dart';
import 'package:telemed/UI/Home/PatientProfilePage.dart';
import 'package:telemed/UI/Home/ReviewProfilePage.dart';
import 'package:telemed/UI/OnboardingPage.dart';
import 'package:telemed/UI/SignInSignUp/BasicInformationPage.dart';
import 'package:telemed/UI/SignInSignUp/HealthInsurancePage.dart';
import 'package:telemed/UI/SignInSignUp/SignInPage.dart';
import 'package:telemed/UI/SignInSignUp/SignUpPage.dart';
import 'package:telemed/settings.dart';

import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    // description
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  print('Got a message whilst in the foreground!');
  print('Message data: ${message.data}');

  if (message.notification != null && android != null) {
    print('Message also contained a notification: ${message.notification}');
    var appIcon = const AndroidInitializationSettings('logo');
    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null) {
      // print("The notification is: " + notification.body!);
      // Map<String, dynamic> jsonInput = jsonDecode(notification.body!);

      // String message = jsonInput['message'];
      String message = notification.body!;
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          message,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: appIcon.defaultIcon,
              // other properties...
            ),
          ));
    }
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TelemedDataProvider()),
      ],
      child: MaterialApp( // Add MaterialApp here
        debugShowCheckedModeBanner: false,
        home: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPopupMessage(); // Show the pop-up message after the frame has been rendered
      loadAllAppMetaDataOnce();
    });
  }

  Future<void> _showPopupMessage() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Welcome!'),
          content: Text('Navigate your device with TalkBack''\n'
              '\n'
              'TalkBack is an accessibility feature in Android designed to assist users who are blind or visually impaired in navigating and interacting with their devices. Here are some basic instructions on how to use TalkBack gestures:''\n'
              '\n'
              'Explore by Touch: Drag your finger across the screen to explore the content. TalkBack will provide audio feedback about the items you touch.''\n'
              '\n'
              'Single Tap: Tap once on an item to select it. This is equivalent to a regular touch or tap on the screen.''\n'
              '\n'
              'Double Tap: Quickly double-tap on an item to activate it or open it. For example, to open an app, double-tap its icon.''\n'
              '\n'
              'Scroll: Use two fingers to scroll through content, such as web pages or lists. Move your two fingers up or down to scroll.''\n'
              '\n'
              // 'Swipe Right/Left: Swipe one finger right or left to navigate between items or elements, such as buttons, links, or text.''\n'
              // '\n'
              // 'Swipe Up/Down: Swipe one finger up or down to cycle through different navigation modes or move to the next or previous item.''\n'
              '\n'
              'Long Press and Hold: To access additional options for an item, long-press and hold it for a few seconds. TalkBack will announce available actions.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> loadAllAppMetaDataOnce() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      // description
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null && android != null) {
        print('Message also contained a notification: ${message.notification}');
        var appIcon = const AndroidInitializationSettings('logo');
        // If `onMessage` is triggered with a notification, construct our own
        // local notification to show to users using the created channel.
        if (notification != null) {
          // print("The notification is: " + notification.body!);
          // Map<String, dynamic> jsonInput = jsonDecode(notification.body!);

          // String message = jsonInput['message'];
          String message = notification.body!;
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              message,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: appIcon.defaultIcon,
                  // other properties...
                ),
              ));
        }
      }
    });
  }

  ThemeData lightThemeData = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      background: Colors.blue.shade100, // Set the background color to blue
      // Add other theme properties as needed
    ),
  );

  ThemeData darkThemeData = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
        // background: Colors.black54, // Set the background color to blue
        // Add other theme properties as needed
        ),
  );

  @override
  Widget build(BuildContext context) {
    var data = context.watch<TelemedDataProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) => TelemedSettings.appName,

      scrollBehavior: MyCustomScrollBehavior(),
      // theme: ThemeData(
      //   useMaterial3: true,
      //   // Comment the following when using material 3
      //   // primarySwatch: Colors.deepPurple,
      //   //
      //   colorSchemeSeed: Colors.deepPurple,
      // ),
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: data.isDark ? ThemeMode.dark : ThemeMode.light,
      initialRoute: OnboardingPage.route,
      routes: {
        OnboardingPage.route: (context) => const OnboardingPage(),
        SignInPage.route: (context) => const SignInPage(),
        SignUpPage.route: (context) => const SignUpPage(),
        BasicInformationPage.route: (context) => const BasicInformationPage(),
        HealthInsurancePage.route: (context) => const HealthInsurancePage(),
        MessagesPage.route: (context) => const MessagesPage(
              shouldPop: false,
            ),
        BasePage.route: (context) => const BasePage(
              subRoute: BasePage.homePage,
            ),

        // HomePage.route: (context) => const HomePage(),
        // ProfilePage.route: (context) => const ProfilePage(),
        BookAppointmentsReasonForVisitPage.route: (context) =>
            const BookAppointmentsReasonForVisitPage(),
        CadersPage.route: (context) => const CadersPage(),
        BookAppointmentPage.route: (context) => const BookAppointmentPage(),
        HealthProfilePage.route: (context) => const HealthProfilePage(),
        ReviewProfilePage.route: (context) => const ReviewProfilePage(),
        PatientProfilePage.route: (context) => const PatientProfilePage(),
        VideoCallPage.route: (context) => const VideoCallPage(),
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        // etc.
      };
}
