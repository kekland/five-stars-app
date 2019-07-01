import 'dart:io';

import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImageSelector extends StatefulWidget {
  final Function(List<File> images) onImageSelect;

  const ImageSelector({Key key, this.onImageSelect}) : super(key: key);
  @override
  _ImageSelectorState createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  List<Asset> images = [];

  void selectImages() async {
    var pickedImages = await MultiImagePicker.pickImages(
      maxImages: 5,
      enableCamera: true,
    );
    if (images != null) {
      images = pickedImages;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleLineInformationWidget(
                label: 'Выбрать изображения',
                icon: Icons.image,
                color: Colors.indigo,
              ),
            ),
            onTap: selectImages,
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0, top: 8.0),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (images.length == 0)
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.black12,
                  ),
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(),
                  ),
                )
              else
                ...(images.map((image) => Padding(
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
                          child: AssetThumb(
                            asset: image,
                            width: 200,
                            height: 200,
                          ),
                        ),
                      ),
                    ))),
            ],
          ),
        ),
      ],
    );
  }
}
