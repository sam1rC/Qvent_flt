import 'package:flutter/material.dart';
import 'package:qvent/pages/event_info.dart';
import 'package:qvent/pages/generated_tickets.dart';
import 'package:qvent/pages/read_tickets.dart';
import 'package:sizer/sizer.dart';
//Pages
import 'pages/home.dart';
import 'pages/create_event.dart';
import 'pages/event_info.dart';
import 'pages/create_tickets.dart';
import 'pages/available_tickets.dart';
import 'pages/read_tickets.dart';
//Firebase import
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of the application..
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Qvent',
          theme: ThemeData(
            colorScheme: const ColorScheme(
                brightness: Brightness.light,
                primary: Color(0xFFD5CEA3),
                onPrimary: Color(0xFF3C2A21),
                secondary: Color(0xFFD5CEA3),
                onSecondary: Color(0xFF3C2A21),
                error: Color(0xFFFFFFFF),
                onError: Color(0x00000000),
                background: Color(0xFF5F8D4E),
                onBackground: Color(0xFF3C2A21),
                surface: Color(0xFFD9D9D9),
                onSurface: Color(0xFF3C2A21)),
            scaffoldBackgroundColor: const Color(0xFF5F8D4E),
            appBarTheme: AppBarTheme(
              color: const Color(0xFF5F8D4E),
              foregroundColor: const Color(0xFFD5CEA3),
              titleTextStyle: TextStyle(
                fontSize: 20.sp,
                color: const Color(0xFFD5CEA3),
              ),
              elevation: 0,
            ),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(
                color: Color(0xFF3C2A21),
                fontWeight: FontWeight.w500,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 15.w, vertical: 1.5.h),
                ),
                textStyle: MaterialStateProperty.all(
                  TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const HomePage(),
            '/create': (context) => const CreateEventPage(),
            '/event_info': (context) => const EventInfoPage(),
            '/create_tickets': (context) => const CreateTicketsPage(),
            '/available_tickets': (context) => const AvailableTicketsPage(),
            '/read_tickets': (context) => const ReadTicketsPage(),
          },
        );
      },
    );
  }
}
