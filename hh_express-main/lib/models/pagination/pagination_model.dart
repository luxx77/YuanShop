import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class PaginationModel extends Equatable {
  const PaginationModel({
    required this.count,
    required this.currentPage,
    required this.lastPage,
    this.nextPageUrl,
    this.prevPageUrl,
    required this.perPage,
    required this.total,
  });
  final int currentPage;
  final int lastPage;
  final String? prevPageUrl;
  final String? nextPageUrl;
  final int perPage;
  final int count;
  final int total;

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);

  @override
  List<Object?> get props =>
      [count, currentPage, total, nextPageUrl, prevPageUrl, perPage, lastPage];
}
