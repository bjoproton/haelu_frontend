// External
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

// Internal

class PageTitle extends StatelessWidget {
  static const ImageProvider image = AssetImage('assets/img/TextSplatter.png');
  final String title;

  PageTitle(this.title);

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder<ui.Image>(
      future: loadImage(),
      builder: (context, snap) {
        if (snap.hasData) {
          print(snap.data);
          return ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (bounds) => ImageShader(
              snap.data!,
              TileMode.clamp,
              TileMode.clamp,
              Matrix4.identity().storage,
            ),
            child: Text(
              title,
              style: TextStyle(fontSize: 172),
              // style: Theme.of(context).textTheme.displaySmall,
            ),
          );
        } else {
          return Container();
        }
      }
    );
  }

  Future<ui.Image> loadImage() async {
    print("loadImage");
    final completer = Completer<ui.Image>();
    final stream = image.resolve(ImageConfiguration());
    stream.addListener(
      ImageStreamListener((info, _) => completer.complete(info.image))
    );
    print("Returning");
    return completer.future;
  }
    
}
