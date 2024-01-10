import 'package:hh_express/data/remote/dio_client.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/models/property/property_model.dart';
import 'package:hh_express/repositories/filters/filters_repository.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FilterRepo)
class FilterRepoImpl extends FilterRepo with DioClientMixin {
  Future<List<PropertyModel>?> getProps() async {
    final response = await dio.get(endPoint: EndPoints.properties);
    if (!response.success) return null;
    final data = response.data[APIKeys.properties] as List;
    final props = data
        .map((e) => PropertyModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return props;
  }
}
