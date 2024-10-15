import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projects/Firebase/userController/userAuth.dart';
import 'package:projects/Views/Authentication/mechanicSignin.dart';
import 'package:projects/firebase_options.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => userAuth(),
        ),
      ],
      child: ResponsiveSizer(
        builder: (Builder, Orientation, ScreenType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Mechanic Online',
            theme: ThemeData(),
            home: mechanicSignin(),
          );
        },
      ),
    );
  }
}
