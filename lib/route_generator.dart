import 'package:flutter/material.dart';
import 'core/auth/presentation/pages/login_page.dart';
import 'features/history/presentation/pages/history_detail_page.dart';
import 'features/menu_page.dart';
import 'features/register/presentation/pages/register_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;

    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case '/menu':
        return MaterialPageRoute(builder: (_) => MenuPage());
      case '/detail':
        return MaterialPageRoute(builder: (_) => HistoryDetailPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
