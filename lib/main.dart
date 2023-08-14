import 'dart:convert';

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
import 'package:telemed/UI/Home/ReviewProfilePage.dart';
import 'package:telemed/UI/OnboardingPage.dart';
import 'package:telemed/UI/SignInSignUp/BasicInformationPage.dart';
import 'package:telemed/UI/SignInSignUp/HealthInsurancePage.dart';
import 'package:telemed/UI/SignInSignUp/SignInPage.dart';
import 'package:telemed/UI/SignInSignUp/SignUpPage.dart';
import 'package:telemed/settings.dart';
import 'package:firebase_core/firebase_core.dart';
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
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TelemedDataProvider()),
      ],
      child: const MyApp(),
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
      loadAllAppMetaDataOnce();
    });
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
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
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
