import 'package:dio/dio.dart';
import 'package:hh_express/data/local/asset_client.dart';
import 'package:hh_express/data/remote/dio_client.dart';
import 'package:hh_express/models/categories/category_model.dart';
import 'package:hh_express/repositories/categories/categories_repository.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoryRepo)
class CategoryRepoIMpl extends CategoryRepo
    with DioClientMixin, AssetClientMixin {
  @override
  Future<Map<String, List<CategoryModel>>?> getAll() async {
    final response = await dio.get(
      endPoint: EndPoints.category,
    );
    if (response.success) {
      final mains = (response.data[APIKeys.mainCategories] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
      final subs = (response.data[APIKeys.subCategories] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return {
        APIKeys.mainCategories: mains,
        APIKeys.subCategories: subs,
      };
    }
    return null;
  }

  @override
  Future<Map<String, List<CategoryModel>>?> getSubsBySlug(
      String slug, CancelToken cancleToken) async {
    final response = await dio.get(
      endPoint: EndPoints.category,
      queryParameters: {
        'slug': slug,
      },
      cancelToken: cancleToken,
    );
    if (response.success) {
      final data = (response.data[APIKeys.subCategories] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return {
        slug: data,
      };
    }
    return null;
  }

  @override
  Future<List<CategoryModel>> getAssetMains() async {
    final mainsJson = await assetBundle.getData(AssetsPath.mainCats);

    final mains = (mainsJson[APIKeys.data] as List<dynamic>)
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return mains;
  }
}
