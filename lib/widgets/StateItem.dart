import 'package:flutter/material.dart';

class StateItem extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;
  final String firstText;
  final String secondText;

  const StateItem({
    Key key,
    this.crossAxisAlignment,
    this.firstText,
    this.secondText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: crossAxisAlignment,
      children: <Widget>[
        Text(
          firstText,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        Text(
          secondText,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w200,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
