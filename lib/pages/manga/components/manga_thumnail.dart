import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_destroyer/components/shimmer.dart';
import 'package:flutter_destroyer/cubits/manga/manga_cubit.dart';
import 'package:flutter_destroyer/models/manga/manga_thumnail.dart';
import 'package:flutter_destroyer/utils/await_builder.dart';

class MangaThumnail extends StatelessWidget {
  final String id;
  final double? height;
  final BoxFit? fit;

  const MangaThumnail({
    super.key,
    required this.id,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return awaitFuture(
      future: context.read<MangaCubit>().getMangaThumnail(id: id),
      wait: SizedBox(
        height: height,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      done: (context, data) {
        if (data == null) {
          return const SizedBox();
        }

        return MangaThumnailDetail(
          height: height,
          fit: fit,
          data: data,
        );
      },
    );
  }
}

class MangaThumnailDetail extends StatefulWidget {
  final double? height;
  final BoxFit? fit;
  final MangaThumnailModel data;

  const MangaThumnailDetail({
    super.key,
    this.height,
    this.fit,
    required this.data,
  });

  @override
  State<MangaThumnailDetail> createState() => _MangaThumnailDetailState();
}

class _MangaThumnailDetailState extends State<MangaThumnailDetail> {
  late final Future<Size> _size;

  @override
  void initState() {
    super.initState();
    _size = _imageSize();
  }

  Future<Size> _imageSize() async {
    Completer<Size> completer = Completer();
    Image provider = Image(image: CachedNetworkImageProvider(widget.data.src));

    provider.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          completer.complete(size);
        },
      ),
    );

    return completer.future;
  }

  Widget _loading() {
    return CustomShimmer(
      child: CustomShimmerBox(
        height: widget.height,
      ),
    );
  }

  Widget _detailWidget(ImageProvider<Object> imageProvider) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: widget.fit,
        ),
      ),
    );
  }

  Widget _detailThumnail(Size? size) {
    return CachedNetworkImage(
      height: widget.height,
      imageUrl: widget.data.src,
      imageBuilder: (context, imageProvider) {
        final child = _detailWidget(imageProvider);

        if (widget.height != null) {
          return child;
        } else {
          if (size == null) return child;

          return AspectRatio(
            aspectRatio: size.aspectRatio,
            child: child,
          );
        }
      },
      placeholder: (context, url) => SizedBox(
        height: widget.height,
        child: _loading(),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.height != null
        ? _detailThumnail(null)
        : FutureBuilder(
            future: _size,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return _loading();
                case ConnectionState.done:
                case ConnectionState.active:
                default:
                  if (snapshot.hasData) {
                    final size = snapshot.data!;
                    return _detailThumnail(size);
                  } else {
                    return _loading();
                  }
              }
            },
          );
  }
}
