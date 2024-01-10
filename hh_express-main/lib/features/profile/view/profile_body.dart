import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hh_express/data/local/secured_storage.dart';
import 'package:hh_express/features/address/cubit/address_cubit.dart';
import 'package:hh_express/features/auth/bloc/auth_bloc.dart';
import 'package:hh_express/features/favors/bloc/favors_bloc.dart';
import 'package:hh_express/features/order_history/cubit/order_history_cubit.dart';
import 'package:hh_express/features/profile/components/profile_list_tile.dart';
import 'package:hh_express/helpers/confirm_exit.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/modal_sheets.dart';
import 'package:hh_express/helpers/routes.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/globals.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});
  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  void initState() {
    super.initState();
  }

  void setContents() {
    contents = List.from(
      [
        authBloc.state.user != null ? '+${authBloc.state.user!.entity}' : '',
        addressState.state.models.isNotEmpty
            ? addressState.state.models.first.address
            : '',
        orderState.state.models.isNotEmpty
            ? orderState.state.models.first.statusTrans
            : '',
        favorsState.state.models.isNotEmpty
            ? favorsState.state.models.first.name
            : '',
        langs[locale.value]!
      ],
    );
  }

  get l10n => context.l10n;

  String get firstIcon {
    return LocalStorage.getToken == null
        ? AssetsPath.phoneIcon
        : AssetsPath.backIcon;
  }

  List<String> get icons => [
        firstIcon,
        AssetsPath.locationIcon,
        AssetsPath.ordersIcon,
        AssetsPath.favorFilled,
        AssetsPath.langIcon,
      ];
  get langs => {
        'tr': l10n.turkmen,
        'ru': l10n.russian,
        'en': l10n.english,
      };

  List<String> get titles => [
        LocalStorage.getToken == null ? l10n.phoneNumber : l10n.logOut,
        l10n.address,
        l10n.myOrders,
        l10n.favorites,
        l10n.programLang,
      ];
  late final favorsState = context.read<FavorsCubit>();
  late final orderState = context.read<OrderHistoryCubit>();
  late final addressState = context.read<AddressCubit>();
  late final authBloc = context.read<AuthBloc>();
  late List<String> contents;
  @override
  Widget build(BuildContext context) {
    setContents();
    return MultiBlocListener(
      listeners: [
        BlocListener<FavorsCubit, FavorsState>(
          listener: (context, state) => setState(() => setContents()),
        ),
        BlocListener<OrderHistoryCubit, OrderHistoryState>(
          listener: (context, state) => setState(() => setContents()),
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) => setState(() => setContents()),
        ),
        BlocListener<AddressCubit, AddressState>(
          listener: (context, state) => setState(() => setContents()),
        )
      ],
      child: Column(
        children: [
          AppSpacing.vertical_30,
          ...List.generate(
            titles.length,
            (index) => ProfileListTile(
              iconPath: icons[index],
              onTap: () {
                authBloc.state.log();
                // return;
                if (index == 0) {
                  if (LocalStorage.getToken != null) {
                    Confirm.showLogOutDialog(context);
                    return;
                  }
                  GoRouter.of(context).push(AppRoutes.auth, extra: true);
                  return;
                }
                index.log();
                ModelBottomSheetHelper.showProfileSheets(index);
              },
              title: titles[index],
              tralling: contents[index],
            ),
          ),
        ],
      ),
    );
  }
}
