import 'package:album_app/screens/authencation/login/login_binding.dart';
import 'package:album_app/screens/authencation/login/login_screen.dart';
import 'package:album_app/screens/authencation/register/register_binding.dart';
import 'package:album_app/screens/authencation/register/register_screen.dart';
import 'package:album_app/screens/home/home_binding.dart';
import 'package:album_app/screens/home/home_screen.dart';
import 'package:get/get.dart';

class Routes {
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const HOME = '/home';

}

class AppPages {
  static const LOGIN = Routes.LOGIN;
  static const REGISTER = Routes.REGISTER;
  static const HOME = Routes.HOME;

  static final routes = [
    GetPage(name: Routes.LOGIN, page: () => LoginScreen(), binding: LoginBinding()),
    GetPage(name: Routes.REGISTER, page: () => RegisterScreen(), binding: RegisterBinding()),
    GetPage(name: Routes.HOME, page: () => HomeScreen(), binding: HomeBinding()),
  ];
}