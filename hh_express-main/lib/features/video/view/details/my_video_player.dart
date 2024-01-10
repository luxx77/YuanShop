import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player_fork/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hh_express/features/components/widgets/place_holder.dart';
import 'package:hh_express/features/video/view/details/cubit/video_details_cubit.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/models/videos/video_model.dart';
import 'package:hh_express/settings/consts.dart';

class MyVideoPlayerWidget extends StatefulWidget {
  const MyVideoPlayerWidget({
    super.key,
    required this.model,
    required this.index,
  });
  final HomeVideoModel model;
  final int index;
  @override
  State<MyVideoPlayerWidget> createState() => _MyVideoPlayerWidgetState();
}

class _MyVideoPlayerWidgetState extends State<MyVideoPlayerWidget> {
  late final vdCubit = context.read<VideoDetailsCubit>();
  late final model = widget.model;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initVideo();
    vdCubit.stream.listen(listener);
    super.initState();
  }

  void listener(VideoDetailsState state) {
    if (!mounted) return;
    if (state.currentPage == widget.index) {
      initVideo();
      return;
    }
    controller?.pause();
  }

  Future<void> initVideo({bool reTry = false}) async {
    if (!mounted) return;
    if (controller != null && !reTry) {
      controller!.play();
      return;
    }
    widget.index.log(message: 'initing');
    controller = await CachedVideoPlayerController.network(model.url);
    await controller!.initialize();
    setState(() {});

    controller!.play();
  }

  CachedVideoPlayerController? controller;

  @override
  Widget build(BuildContext context) {
    return controller == null
        ? _PlaceHolder(model.product.image)
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(),
              GestureDetector(
                onTap: () async {
                  if ((controller!.value.duration.inMilliseconds - 300) <=
                      controller!.value.position.inMilliseconds) {
                    await controller!.seekTo(Duration.zero);
                    setState(() {});
                    return;
                  }
                  if (controller!.value.hasError) return initVideo(reTry: true);
                  if (controller!.value.isPlaying) {
                    await controller!.pause();
                    return;
                  }
                  controller!.play();
                },
                child: AspectRatio(
                  aspectRatio: controller!.value.aspectRatio,
                  child: CachedVideoPlayer(
                    controller!,
                  ),
                ),
              ),
              Padding(
                padding: AppPaddings.all_12,
                child: VideoProgressIndicator(
                  controller!,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                      playedColor: Colors.white,
                      bufferedColor: Colors.grey,
                      backgroundColor: Colors.blueGrey),
                ),
              )
            ],
          );
  }
}

class _PlaceHolder extends StatelessWidget {
  const _PlaceHolder(this.image);
  final String image;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.7,
      child: CachedNetworkImage(
        imageUrl: image,
        placeholder: (context, url) {
          return MyShimerPlaceHolder();
        },
      ),
    );
  }
}
