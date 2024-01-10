import 'dart:async';
import 'package:hh_express/models/auth/auth_model.dart';
import 'package:hh_express/models/auth/user/user_model.dart';

abstract class AuthRepo {
  Future<UserModel?> logIn(AuthModel loginReqModel);
  Future<UserModel?> register(AuthModel loginReqModel);
  Future<bool> logOut();
  Future<UserModel?> authMe();
}
