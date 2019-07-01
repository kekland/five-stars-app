import 'package:five_stars/design/full_screen_image_widget.dart';
import 'package:flutter/material.dart';

class ImagesWidget extends StatelessWidget {
  final List<dynamic> images;

  const ImagesWidget({Key key, this.images}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...(images.map(
            (image) => ImageWidget(
                  image: image,
                  onTap: () => Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (_) =>
                              new FullScreenImagesWidget(images: images, initialPage: images.indexOf(image)),
                        ),
                      ),
                ),
          )),
        ],
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final String image;
  final VoidCallback onTap;
  const ImageWidget({Key key, this.image, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.black12,
        ),
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Stack(
            children: <Widget>[
              Image.network(
                image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
