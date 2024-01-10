import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hh_express/features/categories/view/body.dart';
import 'package:hh_express/features/home/view/components/product_widget.dart';
import 'package:hh_express/features/product_details/bloc/product_details_bloc.dart';
import 'package:hh_express/features/product_details/components/color_builder.dart';
import 'package:hh_express/features/product_details/components/delivery_widget/delivery_widget.dart';
import 'package:hh_express/features/product_details/components/image_indicator.dart';
import 'package:hh_express/features/product_details/components/image_place_holder.dart';
import 'package:hh_express/features/product_details/components/property_builder.dart';
import 'package:hh_express/features/product_details/view/image_details.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/routes.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/enums.dart';
import 'package:hh_express/settings/theme.dart';

class ProdDetailsBody extends StatefulWidget {
  const ProdDetailsBody({super.key, required this.id});
  final int id;
  @override
  State<ProdDetailsBody> createState() => _ProdDetailsBodyState();
}

class _ProdDetailsBodyState extends State<ProdDetailsBody>
    with SingleTickerProviderStateMixin {
  final pageController = PageController();
  @override
  void initState() {
    bloc = context.read<ProductDetailsBloc>()..init(widget.id);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  late final ProductDetailsBloc bloc;

  void pushToImageDetails(
    List<String> images,
    int initIndex,
    Function(int) onChange,
  ) {
    final page = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ImageDetails(
        images: images,
        initIndex: (pageController.page ?? 0).round(),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
    Navigator.push(context, page);
  }

  bool rebuilded = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = context.theme.textTheme;
    final id = widget.id;
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      bloc: bloc,
      buildWhen: (previous, current) {
        final curId = bloc.currentProdId;
        return curId == id;
      },
      builder: (context, ss) {
        final state = bloc.state;
        if (state.state == ProdDetailsAPIState.init) return SizedBox();
        if (state.state == ProdDetailsAPIState.loading)
          return CenterLoading(
            onTap: () {
              state.log();
              bloc.state.log();

              bloc.currentProdId.log();
              id.log();
            },
          );

        if (state.state == ProdDetailsAPIState.error)
          return CategoryErrorBody(
            onTap: () {
              bloc.init(id);
            },
          );

        final product = state.product!;
        final hasDiscount = product.discount != null;
        final l10n = context.l10n;
        return ListView.custom(
          shrinkWrap: true,
          childrenDelegate: SliverChildListDelegate(
            [
              SizedBox(
                height: 350.h,
                child: Stack(
                  children: [
                    PageView.builder(
                      itemCount: product.images.length,
                      controller: pageController,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          pushToImageDetails(
                            product.images,
                            index,
                            (val) {
                              pageController.jumpToPage(val);
                            },
                          );
                        },
                        child: CachedNetworkImage(
                          imageUrl: product.images[index],
                          //! errorWidget
                          errorWidget: (context, url, error) =>
                              ProdDetailsImagePlaceHolder(),
                          placeholder: (context, url) =>
                              ProdDetailsImagePlaceHolder(),
                          height: 300.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ImageIndicator(
                        controller: pageController,
                        total: product.images.length,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: AppPaddings.horiz16_vertic12,
                child: Text(
                  '${product.name}',
                  style: textTheme.titleMedium,
                ),
              ),
              AppSpacing.vertical_4,
              Padding(
                padding: AppPaddings.horiz_16,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      '${AppPaddings.thousandsSeperator(product.salePrice)} TMT',
                      style: AppTheme.titleMedium16(context).copyWith(
                        color: AppColors.appOrange,
                      ),
                    ),
                    AppSpacing.horizontal_8,
                    hasDiscount
                        ? Text(
                            '${AppPaddings.thousandsSeperator(product.discount!)} TMT',
                            style: AppTheme.lineThroughTitleSmall(context),
                            textAlign: TextAlign.start,
                          )
                        : SizedBox(),
                  ],
                ),
              ),
              Padding(
                padding: AppPaddings.bottom12_top20.add(AppPaddings.horiz_16),
                child: Text(
                  l10n.description,
                  style: AppTheme.titleMedium14(context),
                ),
              ),
              Padding(
                padding: AppPaddings.horiz_16,
                child: Text(
                  '${product.description}',
                  style: textTheme.titleSmall,
                ),
              ),
              ...product.properties.map(
                (e) {
                  if (e.isColor) return ProdColorBuilder(model: e);
                  return PropertyBuilder(model: e);
                },
              ).toList(),
              DeliveryWidget(),
              AppSpacing.vertical_26,
              Padding(
                padding: AppPaddings.top_20.add(AppPaddings.horiz_16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      l10n.similarProducts,
                      style: AppTheme.titleMedium14(context),
                    ),
                    TextButton(
                      onPressed: () {
                        context.pushNamed(
                            AppRoutes.moreSimmilarProducts.toRouteName,
                            queryParameters: {'slug': product.categorySlug});
                      },
                      child: Text(
                        l10n.more,
                        style: textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 320.h,
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView.builder(
                    padding: AppPaddings.horiz_12,
                    scrollDirection: Axis.horizontal,
                    itemCount: product.similarProducts.length,
                    itemBuilder: (context, index) {
                      return HomeProdWidget(
                        forProdDetails: true,
                        index: index == 0 ? -1 : -2,
                        prod: product.similarProducts[index],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

final class CenterLoading extends StatelessWidget {
  const CenterLoading({super.key, this.onTap});
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
        ),
        GestureDetector(
          onTap: () {
            if (onTap != null) return onTap!();
          },
          child: CircularProgressIndicator(
            color: AppColors.appOrange,
          ),
        ),
      ],
    );
  }
}
