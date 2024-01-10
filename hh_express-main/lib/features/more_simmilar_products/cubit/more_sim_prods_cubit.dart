import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hh_express/app/setup.dart';
import 'package:hh_express/models/pagination/pagination_model.dart';
import 'package:hh_express/models/products/product_model.dart';
import 'package:hh_express/repositories/products/product_repo.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/enums.dart';

part 'more_sim_prods_state.dart';

class MoreSimProdsCubit extends Cubit<MoreSimProdsState> {
  final String slug;
  MoreSimProdsCubit(this.slug)
      : super(MoreSimProdsState(apiState: ProductAPIState.init));
  final _repo = getIt<ProductRepo>();
  Future<void> init({bool forUpdate = false}) async {
    if (state.apiState != ProductAPIState.init &&
        state.apiState != ProductAPIState.error &&
        !forUpdate) {
      return;
    }
    emit(MoreSimProdsState(apiState: ProductAPIState.loading));
    final data = await _repo.getProducts(
      slugs: List<String>.from([slug]),
      properties: List.empty(),
      page: 0,
    );

    if (data != null) {
      return emit(
        MoreSimProdsState(
          apiState: ProductAPIState.success,
          pagination: data[APIKeys.pagination],
          products: List.from(data[APIKeys.products]),
        ),
      );
    }
    return emit(MoreSimProdsState(apiState: ProductAPIState.error));
  }

  Future<void> loadMore() async {
    if (state.pagination!.currentPage == state.pagination!.lastPage) return;
    emit(state.copyWith(apiState: ProductAPIState.loadingMore));
    final data = await _repo.getProducts(
      slugs: List<String>.from([slug]),
      properties: List.empty(),
      page: state.pagination!.currentPage + 1,
    );

    if (data != null) {
      return emit(
        MoreSimProdsState(
          apiState: ProductAPIState.success,
          pagination: data[APIKeys.pagination],
          products: List.from(state.products ?? [])
            ..addAll(data[APIKeys.products]),
        ),
      );
    }
    return emit(state.copyWith(apiState: ProductAPIState.loadingMoreError));
  }
}
