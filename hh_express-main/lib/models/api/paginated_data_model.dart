import 'package:hh_express/models/pagination/pagination_model.dart';

class PaginatedDataModel<T> {
  const PaginatedDataModel({
    required this.data,
    required this.pagination,
  });
  final T data;
  final PaginationModel pagination;
}
