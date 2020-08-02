import 'package:flutter/material.dart';
import 'package:Shravik/ui/auth/signup.dart';
import 'package:Shravik/ui/category.dart';
import 'package:Shravik/ui/infocards.dart';
import 'package:Shravik/ui/search.dart';
import 'package:Shravik/ui/searchfilters.dart';
import 'package:Shravik/ui/ui.dart';
import 'package:Shravik/ui/auth/auth.dart';
import 'package:Shravik/ui/welcome.dart';

class Routes {
  Routes._();
  static const String signin = '/signin';
  static const String home = '/home';
  static const String settings = '/settings';
  static const String resetPassword = '/reset-password';
  static const String updateProfile = '/update-profile';
  static const String welcome = '/welcome';
  static const String info = '/info';
  static const String search = '/search';
  static const String search_employer = '/search_employer';
  static const String category = '/category';
  static const String signup = '/signup';
  static const String searchfilter = '/searchfilter';

  static final routes = <String, WidgetBuilder>{
    signin: (BuildContext context) => SignInUI(),
    settings: (BuildContext context) => SettingsUI(),
    resetPassword: (BuildContext context) => ResetPasswordUI(),
    home: (BuildContext context) => HomeUI(),
    welcome: (BuildContext context) => Welcome(),
    info: (BuildContext context) => InfoCards(),
    search: (BuildContext context) => WhoAreU(),
    category: (BuildContext context) => CategoryReg(),
    signup: (BuildContext context) => Signup(),
    searchfilter: (BuildContext context) => SearchFilters(),
  };
}
