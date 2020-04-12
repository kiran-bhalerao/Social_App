import 'package:draggable_sheet/models/profile.dart';
import 'package:draggable_sheet/widgets/StateItem.dart';
import 'package:flutter/material.dart';

class ProfilePageView extends StatefulWidget {
  final Function onChangePage;

  const ProfilePageView({Key key, this.onChangePage}) : super(key: key);

  @override
  _ProfilePageViewState createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  AnimationController _animationController;
  PageController _pageController;
  Animation _slideAnimation;
  Animation _fadeAnimation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _pageController = PageController(initialPage: 0);

    _slideAnimation = TweenSequence<Offset>([
      TweenSequenceItem(
          weight: 10, tween: Tween(begin: Offset(0, 0), end: Offset(0, 1))),
      TweenSequenceItem(
          weight: 90, tween: Tween(begin: Offset(0, 1), end: Offset(0, 0))),
    ]).animate(_animationController);

    _fadeAnimation = TweenSequence<double>([
      TweenSequenceItem(weight: 20, tween: Tween(begin: 1, end: 0)),
      TweenSequenceItem(weight: 80, tween: Tween(begin: 0, end: 1)),
    ]).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView.builder(
          itemCount: profiles.length,
          controller: _pageController,
          onPageChanged: (idx) {
            setState(() {
              currentIndex = idx;
              _animationController.reset();
              _animationController.forward();
            });
            widget.onChangePage(idx);
          },
          itemBuilder: (ctx, idx) {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(
                  profiles[idx].imagePath,
                  fit: BoxFit.cover,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.2),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        Positioned(
          bottom: 50,
          left: 20,
          right: 20,
          child: ProfileStats(
            index: currentIndex,
            slideAnimation: _slideAnimation,
            fadeAnimation: _fadeAnimation,
          ),
        )
      ],
    );
  }
}

class ProfileStats extends StatelessWidget {
  final int index;
  final Animation slideAnimation;
  final Animation fadeAnimation;

  const ProfileStats({
    Key key,
    @required this.index,
    @required this.slideAnimation,
    @required this.fadeAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            StateItem(
              crossAxisAlignment: CrossAxisAlignment.start,
              firstText: profiles[index].followings.toString(),
              secondText: 'Followings',
            ),
            StateItem(
              crossAxisAlignment: CrossAxisAlignment.center,
              firstText: profiles[index].posts.toString(),
              secondText: 'Posts',
            ),
            StateItem(
              crossAxisAlignment: CrossAxisAlignment.end,
              firstText: profiles[index].followers.toString(),
              secondText: 'Followers',
            ),
          ],
        ),
      ),
    );
  }
}
