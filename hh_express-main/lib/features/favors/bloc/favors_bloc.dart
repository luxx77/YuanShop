import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hh_express/app/setup.dart';
import 'package:hh_express/data/local/secured_storage.dart';
import 'package:hh_express/models/cart/cart_product_model/cart_product_model.dart';
import 'package:hh_express/models/pagination/pagination_model.dart';
import 'package:hh_express/repositories/profile/favorites/favorites_repository.dart';
import 'package:hh_express/settings/enums.dart';

part 'favors_state.dart';

class FavorsCubit extends Cubit<FavorsState> {
  FavorsCubit() : super(FavorsState.deftState);
  final _repo = getIt<FavorsRepo>();
  bool _isSwitching = false;
  Future<void> getFavors() async {
    if (LocalStorage.getToken == null) {
      return emit(
        FavorsState(
          apiState: FavorsAPIState.unauthorized,
          models: List.empty(growable: true),
        ),
      );
    }
    emit(
      FavorsState(
        apiState: FavorsAPIState.loading,
        models: List.empty(
          growable: true,
        ),
      ),
    );

    final response =
        await _repo.getFavors((state.pagination?.currentPage ?? 0) + 1);
    if (response != null) {
      return emit(
        FavorsState(
          pagination: response.pagination,
          apiState: FavorsAPIState.success,
          models: List.from(state.models)..addAll(response.data),
        ),
      );
    }
    emit(
      FavorsState(
        apiState: FavorsAPIState.error,
        models: List.from(state.models),
        pagination: state.pagination,
      ),
    );
  }

  Future<bool?> switchFavor(CartProductModel model) async {
    if (_isSwitching) {
      return false;
    }
    _isSwitching = true;
    final data = await _repo.switchFavor(model.id);
    if (data != null) {
      final newList = List<CartProductModel>.from(state.models);
      try {
        if (data) {
          newList.add(model);
        } else {
          final index = findIndex(model.id);
          newList.removeAt(index);
        }
      } catch (e) {}
      emit(state.copyWith(models: List.from(newList)));
      _isSwitching = false;
      return data;
    }
    _isSwitching = false;
    return null;
  }

  bool isFavor(int id) {
    return findIndex(id) != -1;
  }

  int findIndex(int id) {
    final idList = state.models.map((e) => e.id).toList();
    return idList.indexOf(id);
  }

  Future<void> loadMore() async {
    if (state.pagination == null ||
        state.pagination!.currentPage == state.pagination!.lastPage) return;
    emit(
      FavorsState(
        apiState: FavorsAPIState.loadingMore,
        pagination: state.pagination,
        models: state.models,
      ),
    );

    final response =
        await _repo.getFavors((state.pagination?.currentPage ?? 0) + 1);
    if (response != null) {
      return emit(
        FavorsState(
          apiState: FavorsAPIState.success,
          models: List.from(state.models)..addAll(response.data),
          pagination: response.pagination,
        ),
      );
    }
    emit(
      FavorsState(
        apiState: FavorsAPIState.errorMore,
        models: List.from(state.models),
        pagination: state.pagination,
      ),
    );
  }
}
