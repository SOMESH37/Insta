// social_media_widgets with little modifications
import '../helper.dart';
import 'dart:ui';

class AStory extends StatelessWidget {
  final int index;
  AStory(this.index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenH,
        width: screenW,
        color: Colors.primaries[index % 17],
        child: Stack(
          children: [
            SafeArea(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                    child: circularImg(
                        'https://picsum.photos/id/${index + 10}/200', 42),
                  ),
                  Text('${allAccounts[index % 3 + 1][2]}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.headline5),
                  Spacer(),
                  IconButton(
                    splashRadius: 1,
                    tooltip: 'Close',
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .backgroundColor,
                    icon: Icon(Icons.close_rounded),
                    iconSize: 28,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Center(
              child: FadeInImage(
                width: screenW - 100,
                fit: BoxFit.contain,
                fadeInDuration: Duration(milliseconds: 100),
                fadeOutDuration: Duration(milliseconds: 100),
                placeholder: AssetImage(resourceHelper[1]),
                image:
                    NetworkImage('https://picsum.photos/id/${index + 505}/400'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StorySwipe extends StatefulWidget {
  final int whichIdx;
  StorySwipe(this.whichIdx);
  @override
  _StorySwipeState createState() => _StorySwipeState();
}

class _StorySwipeState extends State<StorySwipe> {
  PageController _pageController;
  double currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.whichIdx);
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) {
        if (details.globalPosition.dx < screenW / 3)
          _pageController.previousPage(
            curve: Curves.easeOutExpo,
            duration: Duration(milliseconds: 400),
          );
        if (details.globalPosition.dx > 2 * screenW / 3)
          _pageController.nextPage(
            curve: Curves.easeOutCirc,
            duration: Duration(milliseconds: 350),
          );
      },
      child: PageView.builder(
        controller: _pageController,
        itemCount: 19,
        itemBuilder: (contxt, index) {
          double value;
          if (_pageController.position.haveDimensions == false) {
            value = index.toDouble();
          } else {
            value = _pageController.page;
          }
          return GestureDetector(
            onVerticalDragEnd: (details) =>
                details.velocity.pixelsPerSecond.direction > 0
                    ? Navigator.pop(context)
                    : null,
            child: _SwipeWidget(
              index: index,
              pageNotifier: value,
              child: Hero(
                  transitionOnUserGestures: true,
                  tag: 'toStory${widget.whichIdx}',
                  child: AStory(index)),
            ),
          );
        },
      ),
    );
  }
}

num degToRad(num deg) => deg * (pi / 180.0);

class _SwipeWidget extends StatelessWidget {
  final int index;

  final double pageNotifier;

  final Widget child;

  const _SwipeWidget({
    Key key,
    @required this.index,
    @required this.pageNotifier,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLeaving = (index - pageNotifier) <= 0;
    final t = (index - pageNotifier);
    final rotationY = lerpDouble(0, 90, t);
    // final opacity = lerpDouble(0, 1, t.abs()).clamp(0.0, 1.0);
    final transform = Matrix4.identity();
    transform.setEntry(3, 2, 0.001);
    transform.rotateY(-degToRad(rotationY));
    return Transform(
        alignment: isLeaving ? Alignment.centerRight : Alignment.centerLeft,
        transform: transform,
        child: child);
  }
}
