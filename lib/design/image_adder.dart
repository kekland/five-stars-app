import 'dart:io';

import 'package:five_stars/design/shadows/shadows.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImageSelector extends StatefulWidget {
  final Function(List<File> images) onImageSelect;
  final List<File> images;

  const ImageSelector({Key key, this.onImageSelect, this.images})
      : super(key: key);
  @override
  _ImageSelectorState createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  List<File> images = [];

  @override
  void didUpdateWidget(ImageSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.images != widget.images) {
      this.images = widget.images;
    }
  }

  void selectImages() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxWidth: 1024, maxHeight: 1024);
    if (image != null) {
      images.add(image);
      widget.onImageSelect(images);
      setState(() {});
    }
  }

  @override
  void initState() {
    images = widget.images;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...(images.map(
            (image) => Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Stack(
                    fit: StackFit.loose,
                    children: <Widget>[
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
                          child: Image.file(
                            image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: Container(
                          width: 36.0,
                          height: 36.0,
                          decoration: BoxDecoration(
                            color: ModernColorTheme.main,
                            shape: BoxShape.circle,
                            boxShadow: [Shadows.slightShadow]
                          ),
                          child: Material(
                            type: MaterialType.transparency,
                            borderRadius: BorderRadius.circular(18.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(18.0),
                              onTap: () => setState(() => images.remove(image)),
                              child: Icon(Icons.close, color: Colors.white, size: 18.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          )),
          if (images.length < 5)
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.black12,
              ),
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Center(
                      child: Icon(FontAwesomeIcons.plus, color: Colors.white)),
                  onTap: selectImages,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
