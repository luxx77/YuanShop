import 'package:hh_express/data/local/secured_storage.dart';
import 'package:hh_express/data/remote/dio_client.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/models/auth/auth_model.dart';
import 'package:hh_express/models/auth/user/user_model.dart';
import 'package:hh_express/repositories/auth/auth_repositori.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl extends AuthRepo with DioClientMixin {
  @override
  Future<UserModel?> logIn(AuthModel model) async {
    final response = await dio.post(
      endPoint: EndPoints.logIn,
      data: model.toJson(),
    );
    if (response.success) {
      final token = response.data[APIKeys.accsesToken] as String;
      final user = UserModel.fromJson(response.data[APIKeys.user]);
      await LocalStorage.saveToken(token..log(message: 'Tooken'));
      return user;
    }
    return null;
  }

  @override
  Future<UserModel?> register(AuthModel model) async {
    final response = await dio.post(
      endPoint: EndPoints.register,
      data: model.toJson(),
    );
    if (response.success) {
      final token = response.data[APIKeys.accsesToken] as String;
      final user = UserModel.fromJson(response.data[APIKeys.user]);

      await LocalStorage.saveToken((token)..log(message: 'Tokeen'));
      return user;
    }

    return null;
  }

  @override
  Future<bool> logOut() async {
    final response = await dio.post(endPoint: EndPoints.logOut);
    if (response.success) {
      await LocalStorage.deleteToken();
    }
    return response.success;
  }

  @override
  Future<UserModel?> authMe() async {
    if (LocalStorage.getToken == null) return null;
    final response = await dio.get(endPoint: EndPoints.authMe);
    if (response.success) {
      final user = UserModel.fromJson(response.data[APIKeys.user]);
      return user;
    }
    return null;
  }
}
