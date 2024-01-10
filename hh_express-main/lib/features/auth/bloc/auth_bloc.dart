import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hh_express/app/setup.dart';
import 'package:hh_express/features/address/cubit/address_cubit.dart';
import 'package:hh_express/features/cart/cubit/cart_cubit.dart';
import 'package:hh_express/features/favors/bloc/favors_bloc.dart';
import 'package:hh_express/features/order_history/cubit/order_history_cubit.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/overlay_helper.dart';
import 'package:hh_express/helpers/routes.dart';
import 'package:hh_express/models/auth/auth_model.dart';
import 'package:hh_express/models/auth/user/user_model.dart';
import 'package:hh_express/repositories/auth/auth_repositori.dart';
import 'package:hh_express/settings/enums.dart';

part 'auth_state.dart';

class AuthBloc extends Cubit<AuthState> {
  AuthBloc() : super(AuthState(apiState: APIState.init, termsConfirmed: false));
  final _repo = getIt<AuthRepo>();

  void confirmTerms(bool val) {
    emit(
      AuthState(
        user: state.user,
        apiState: APIState.init,
        termsConfirmed: val,
      ),
    );
  }

  Future<void> authMe() async {
    emit(
      AuthState(
        user: state.user,
        apiState: APIState.loading,
        termsConfirmed: state.termsConfirmed,
      ),
    );
    final response = await _repo.authMe();
    final isSuccess = response != null;
    emit(
      AuthState(
        apiState: isSuccess ? APIState.success : APIState.error,
        message: isSuccess ? 'Success' : 'error',
        termsConfirmed: state.termsConfirmed,
        user: response,
      ),
    );
  }

  bool checkName(String? name) {
    'theName $name'.log();
    if (name == null || name.length >= 5) {
      return true;
    }
    SnackBarHelper.showTopSnack('user name is wrong', APIState.error);
    if (name.contains('')) {
      emit(
        AuthState(
          apiState: APIState.error,
          message: 'length of UserName less than 5',
          termsConfirmed: state.termsConfirmed,
        ),
      );
    }
    emit(
      AuthState(
        user: state.user,
        apiState: APIState.error,
        message: 'length of UserName less than 5',
        termsConfirmed: state.termsConfirmed,
      ),
    );
    return false;
  }

  bool checkTerms() {
    final val = state.termsConfirmed;
    if (!val) {
      SnackBarHelper.showTopSnack('Confirm Terms of usage', APIState.error);
    }
    return val;
  }

  bool checkNum(String num) {
    num.log();
    if (num.length != 11) {
      SnackBarHelper.showTopSnack(
          'length of Number less than 8', APIState.error);

      emit(
        AuthState(
          apiState: APIState.error,
          message: 'length of Number less than 8',
          termsConfirmed: state.termsConfirmed,
        ),
      );
      'Number is incorrect'.log();
      return false;
    }
    return true;
  }

  bool checkPass(String model) {
    if (model.length < 5) {
      SnackBarHelper.showTopSnack(
          'Length of password less than 5', APIState.error);

      emit(AuthState(
          apiState: APIState.error,
          message: 'Length of password less than 5',
          termsConfirmed: state.termsConfirmed));
      'password Length must be more than 8'.log();
      return false;
    }
    return true;
  }

  Future<bool> logIn(AuthModel data) async {
    emit(
      AuthState(
        user: state.user,
        apiState: APIState.loading,
        termsConfirmed: state.termsConfirmed,
      ),
    );
    OverlayHelper.showLoading();
    final response = await _repo.logIn(data);
    final isSuccess = response != null;
    if (isSuccess) {
      appRouter.pop();
      SnackBarHelper.showTopSnack(
        appRouter.currentContext.l10n.succsess,
        APIState.success,
      );
      emit(
        AuthState(
          apiState: APIState.success,
          termsConfirmed: state.termsConfirmed,
          user: response,
          message: state.message,
        ),
      );
      reInitOtherScreens();
    }
    emit(
      AuthState(
        apiState: isSuccess ? APIState.success : APIState.error,
        message: isSuccess ? 'Success' : 'error',
        termsConfirmed: state.termsConfirmed,
        user: state.user,
      ),
    );
    OverlayHelper.remove();
    return isSuccess;
  }

  Future<bool> logOut() async {
    emit(
      AuthState(
        user: state.user,
        apiState: APIState.loading,
        termsConfirmed: state.termsConfirmed,
      ),
    );
    OverlayHelper.showLoading();
    'request.log'.log();
    final response = await _repo.logOut();
    if (response) {
      reInitOtherScreens();
      OverlayHelper.remove();
      SnackBarHelper.showTopSnack(
        appRouter.currentContext.l10n.succsess,
        APIState.success,
      );
      emit(
        AuthState(
          apiState: APIState.success,
          termsConfirmed: state.termsConfirmed,
        ),
      );
      return response;
    }
    emit(
      AuthState(
        user: state.user,
        apiState: APIState.error,
        message: 'somehings went wrong',
        termsConfirmed: state.termsConfirmed,
      ),
    );

    OverlayHelper.remove();
    return false;
  }

  Future<bool> singUp(AuthModel model) async {
    emit(
      AuthState(
        user: state.user,
        apiState: APIState.loading,
        termsConfirmed: state.termsConfirmed,
      ),
    );
    OverlayHelper.showLoading();
    final response = await _repo.register(model);
    final isSuccess = response != null;
    if (isSuccess) {
      appRouter.pop();
      SnackBarHelper.showTopSnack(
        appRouter.currentContext.l10n.succsess,
        APIState.success,
      );
      emit(
        AuthState(
          apiState: APIState.success,
          termsConfirmed: state.termsConfirmed,
          user: response,
        ),
      );
      reInitOtherScreens();
    }
    emit(
      AuthState(
        user: state.user,
        apiState: isSuccess ? APIState.success : APIState.error,
        message: isSuccess ? 'Success' : 'error',
        termsConfirmed: state.termsConfirmed,
      ),
    );
    OverlayHelper.remove();
    return isSuccess;
  }

  void wrongState(String message) {
    SnackBarHelper.showTopSnack(
      message,
      APIState.success,
    );
    emit(
      AuthState(
        user: state.user,
        apiState: APIState.error,
        message: message,
        termsConfirmed: state.termsConfirmed,
      ),
    );
  }

  void reInitOtherScreens() {
    final context = appRouter.currentContext;
    context.read<AddressCubit>().init();
    context.read<CartCubit>().getCurrentCart();
    context.read<OrderHistoryCubit>().init(forUpdate: true);
    context.read<FavorsCubit>().getFavors();
  }
}
