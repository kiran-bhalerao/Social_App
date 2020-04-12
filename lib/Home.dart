import 'package:draggable_sheet/Profile.dart';
import 'package:draggable_sheet/models/profile.dart';
import 'package:draggable_sheet/widgets/AppBottomBar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _heightAnimation;

  double screenHeight;
  double collapseHeightFactor = 0.92;
  double expandedHeightFactor = 0.62;
  bool animationCompleted = false;
  int currentPage = 0;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _heightAnimation =
        Tween<double>(begin: collapseHeightFactor, end: expandedHeightFactor)
            .animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  onBottomPartTap() {
    setState(() {
      if (animationCompleted) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
      animationCompleted = !animationCompleted;
    });
  }

  void _handleVerticalUpdate(DragUpdateDetails details) {
    double fractionDragged = details.primaryDelta / screenHeight;
    _animationController.value =
        _animationController.value - 5 * fractionDragged;
  }

  void _handleVerticalEnd(DragEndDetails details) {
    if (_animationController.value >= 0.5) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void changeCurrentPage(int page) {
    setState(() {
      currentPage = page;
    });
  }

  Widget getWidget() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        FractionallySizedBox(
          heightFactor: _heightAnimation.value,
          alignment: Alignment.topCenter,
          child: ProfilePageView(onChangePage: changeCurrentPage),
        ),
        GestureDetector(
          onTap: onBottomPartTap,
          onVerticalDragUpdate: _handleVerticalUpdate,
          onVerticalDragEnd: _handleVerticalEnd,
          child: FractionallySizedBox(
            heightFactor: 1.05 - _heightAnimation.value,
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Color(0xFFEEEEEE),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 22, 22, 0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                profiles[currentPage].name,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${profiles[currentPage].city}, ${profiles[currentPage].country}',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          OutlineButton(
                            child: Text(
                              'FOLLOW',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 11),
                              child: Text(profiles[currentPage].bio),
                            ),
                            Text(
                              'Photos',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              height: 140,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 4,
                                itemBuilder: (ctx, index) {
                                  return Container(
                                    height: 140,
                                    width: 140,
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/${index + 1}.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) => getWidget(),
      ),
      bottomNavigationBar: AppBottomBar(),
    );
  }
}
