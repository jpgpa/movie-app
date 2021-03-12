import 'package:flutter/material.dart';
import 'package:loading_skeleton/loading_skeleton.dart';

class LoadingCardSwiper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: LoadingSkeleton(
          width: _screenSize.width * 0.7,
          height: _screenSize.height * 0.5,
        ),
      ),
    );
  }
}
