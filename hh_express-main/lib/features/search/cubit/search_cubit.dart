import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hh_express/app/setup.dart';
import 'package:hh_express/models/pagination/pagination_model.dart';
import 'package:hh_express/models/products/product_model.dart';
import 'package:hh_express/repositories/products/product_repo.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/enums.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState.initState);
  final _repo = getIt<ProductRepo>();
  String fieldVal = '';
  Future<void> search({bool immediately = false}) async {
    if (!await doSearch(immediately)) return;
    emit(
      SearchState(
        apiState: SearchAPIState.loading,
        models: null,
        pagination: null,
      ),
    );
    final response = await _repo.getProducts(
      search: fieldVal.toLowerCase(),
      slugs: List.empty(),
      properties: List.empty(),
      page: 1,
    );
    if (response != null) {
      return emit(
        SearchState(
          apiState: SearchAPIState.success,
          models: List.from(response[APIKeys.products]),
          pagination: response[APIKeys.pagination],
        ),
      );
    }
    return emit(state.update(apiState: SearchAPIState.error));
  }

  Future<void> loadMore() async {
    emit(state.update(apiState: SearchAPIState.loadingMore));
    final response = await _repo.getProducts(
      slugs: List.empty(),
      properties: List.empty(),
      page: state.pagination!.currentPage + 1,
      search: fieldVal,
    );
    if (response != null) {
      return emit(
        SearchState(
          apiState: SearchAPIState.success,
          models: List.from(state.models!)..addAll(response[APIKeys.products]),
          pagination: response[APIKeys.pagination],
        ),
      );
    }

    return emit(state.update(apiState: SearchAPIState.errorMore));
  }

  Future<bool> doSearch(bool immediately) async {
    _searchId++;
    if (immediately) return true;
    final myId = _searchId;
    await Future.delayed(AppDurations.duration_500ms);
    return myId == _searchId;
  }

  int _searchId = 0;
}
