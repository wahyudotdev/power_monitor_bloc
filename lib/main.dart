import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'core/auth/presentation/bloc/auth_bloc.dart';
import 'features/splash_screen.dart';
import 'route_generator.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  await di.sl.allReady();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => di.sl<AuthBloc>())
      ],
      child: MaterialApp(
        title: 'Power Monitoring',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        home: SplashScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
