
import 'package:dio/dio.dart';
import 'package:hh_express/data/local/asset_client.dart';
import 'package:hh_express/data/remote/dio_client.dart';
import 'package:hh_express/models/api/response_model.dart';
import 'package:hh_express/repositories/chat/chat_repository.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChatRepo)
class ChatRepoIMpl extends ChatRepo with DioClientMixin, AssetClientMixin {
  @override
  Future<ApiResponse> getMessagesList(int page) async {
    final response =
        await dio.get(endPoint: EndPoints.chatMessagesList, queryParameters: {
      'page': page,
    });
    return response;
  }

  @override
  Future<ApiResponse> sendMessage(
      {String? message, XFile? file, required String type}) async {
    late FormData formData;
    if (file != null) {
      String fileName = file.path.split('/').last;
      formData = FormData.fromMap(
        {
          'type': 'file',
          "file": await MultipartFile.fromFile(file.path, filename: fileName),
        },
      );
    }
    final response = await dio.post(
      endPoint: EndPoints.chatSend,
      options: type != 'text'
          ? Options(
              headers: {
                'accept-type': 'multipart/form-data',
              },
            )
          : null,
      data: type == 'text'
          ? {
              'type': 'text',
              'message': message,
            }
          : formData,
    );
    return response;
  }
}
