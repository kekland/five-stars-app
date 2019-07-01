import 'package:five_stars/design/circular_progress_reveal_widget.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImagesWidget extends StatefulWidget {
  final List<dynamic> images;
  final int initialPage;

  const FullScreenImagesWidget({Key key, this.images, this.initialPage})
      : super(key: key);
  @override
  _FullScreenImagesWidgetState createState() => _FullScreenImagesWidgetState();
}

class _FullScreenImagesWidgetState extends State<FullScreenImagesWidget> {
  PageController controller;

  int currentPage;
  initState() {
    super.initState();
    currentPage = widget.initialPage;
    controller = PageController(initialPage: widget.initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          '${currentPage + 1} / ${widget.images.length}',
          style: ModernTextTheme.primaryAccented.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: PageView.builder(
          itemCount: widget.images.length,
          controller: controller,
          onPageChanged: (index) => setState(() => currentPage = index),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => new PhotoView(
                imageProvider: NetworkImage(widget.images[index]),
                minScale: 1.0,
                maxScale: 3.0,
              ),
        ),
      ),
    );
  }
}
