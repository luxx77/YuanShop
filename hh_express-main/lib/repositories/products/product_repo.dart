import 'package:dio/dio.dart';
import 'package:hh_express/features/terms_of_usage/usage_terms_model.dart';
import 'package:hh_express/models/delivery_info/deliery_info_model.dart';
import 'package:hh_express/models/product_details/product_details_model.dart';

abstract class ProductRepo {
  Future<Map<String, dynamic>?> getProducts({
    required List<String> slugs,
    required List<int> properties,
    required int page,
    String? search,
    int? videoId,
  });
  Future<DeliveryInfoModel?> getDeliveryInfo();
  Future<UsageTermsModel?> getTermsOfUsage();
  Future<ProductDetailsModel?> getDetails(int id, CancelToken cancelToken);
}
