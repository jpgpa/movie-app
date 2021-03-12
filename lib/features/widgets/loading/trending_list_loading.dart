import 'package:flutter/material.dart';
import 'package:loading_skeleton/loading_skeleton.dart';

class TrendingListLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.2,
      width: _screenSize.width * 0.2,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, i) => _card(ctx, _screenSize),
        itemCount: 10,
      ),
    );
  }

  Widget _card(BuildContext context, Size screenSize) {
    return Flexible(
      child: Container(
        width: screenSize.width * 0.25,
        margin: EdgeInsets.only(right: 10.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: LoadingSkeleton(width: 100.0, height: 105.0),
            ),
            SizedBox(
              height: 5.0,
            ),
            LoadingSkeleton(width: 100.0, height: 15.0),
          ],
        ),
      ),
    );
  }
}
