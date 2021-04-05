import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';
import '../helper.dart';
import './story_swipe.dart';

AnimationController _hide;
List<GlobalKey<NavigatorState>> navKeys = [
  GlobalKey<NavigatorState>(),
  GlobalKey<NavigatorState>(),
  GlobalKey<NavigatorState>(),
  GlobalKey<NavigatorState>(),
  GlobalKey<NavigatorState>(),
];
PageController pageController = PageController(keepPage: true);

/*
>> Can be used to hide/ show bottom nav bar according to user's scroll 
   NotificationListener( onNotification: (listen) {  if (listen is UserScrollNotification && listen.depth == 0 && (Provider.of<BottomNavBar>(context, listen: false).getCurrentIndex == 6)) {
                switch (listen.direction) {
                  case ScrollDirection.forward:
                    _hide.forward();
                    break;
                  case ScrollDirection.reverse:
                    _hide.reverse();
                    break;
                  case ScrollDirection.idle:
                    break;  }    } if (listen is OverscrollIndicatorNotification)   listen.disallowGlow();  return;   }, child: );
*/
class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  bool isDrawerOpen = false;
  int _currentIndex;

  void toggleDrawer(bool switchTo) =>
      mounted ? setState(() => isDrawerOpen = switchTo) : null;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        mainContext = context;
        screenH = MediaQuery.of(context).size.height;
        screenW = MediaQuery.of(context).size.width;
        return Scaffold(
          // backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          body: WillPopScope(
            onWillPop: () async {
              _currentIndex = context.read<BottomNavBar>().getCurrentIndex;
              if (pageController.page != 0)
                pageController.previousPage(
                    duration: Duration(milliseconds: 150),
                    curve: Curves.easeIn);
              else if (isDrawerOpen)
                toggleDrawer(false);
              else if (_currentIndex != 2 &&
                  await navKeys[_currentIndex].currentState.maybePop())
                return false;
              else if (_currentIndex != 0)
                navigateTo(context, 0);
              else if (_currentIndex == 0) return true;
              return false;
            },
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                MyDrawer(toggleDrawer),
                AnimatedContainer(
                  transform: Matrix4.translationValues(
                      isDrawerOpen ? -screenW * 0.38 : 0,
                      isDrawerOpen ? screenH * 0.18 : 0,
                      0)
                    // for perspective
                    ..setEntry(3, 2, 0.0006)
                    ..scale(isDrawerOpen ? 0.7 : 1.0)
                    ..rotateY(isDrawerOpen ? -0.12 : 0.0),
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInCubic,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(isDrawerOpen ? 16 : 0),
                    boxShadow: [
                      BoxShadow(
                        color: context.watch<MyTheme>().currentTheme ==
                                MyTheme.myLight
                            ? Colors.grey[300]
                            : Colors.grey[850],
                        blurRadius: 28,
                        spreadRadius: -1.4,
                        offset: Offset(-14, 14),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: GestureDetector(
                    onTap: () => toggleDrawer(false),
                    child: AbsorbPointer(
                      //  so that inner widgets won't recieve any gesture
                      absorbing: isDrawerOpen,
                      child: PageView(
                        controller: pageController,
                        children: [
                          Home(toggleDrawer),
                          if (Provider.of<BottomNavBar>(context)
                                  .getCurrentIndex ==
                              0)
                            Chat(),
                        ],
                      ),
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: isPreview.stream,
                  builder: (_, snap) => snap.data == true // it can also be null
                      ? ZoomImg(currentPreviewImgUrl)
                      : SizedBox.shrink(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

navigateTo(context, index) {
  if (Provider.of<BottomNavBar>(context, listen: false).getCurrentIndex ==
      index) {
    /* can be used for
         -scroll to top
         -refresh items
      */
  } else
    Provider.of<BottomNavBar>(context, listen: false).setCurrentIndex = index;
}

class Home extends StatefulWidget {
  final toggleDrawer;
  Home(this.toggleDrawer);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin<Home> {
  @override
  void initState() {
    super.initState();
    _hide =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    _hide.forward();
  }

  @override
  void dispose() {
    _hide.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: Provider.of<BottomNavBar>(context).getCurrentIndex,
        children: [
          Navigator(
              key: navKeys[0],
              onGenerateRoute: (settings) =>
                  MaterialPageRoute(builder: (context) => Feed())),
          Navigator(
              key: navKeys[1],
              onGenerateRoute: (settings) =>
                  MaterialPageRoute(builder: (context) => Explore())),
          CreatePost(),
          Navigator(
              key: navKeys[3],
              onGenerateRoute: (settings) =>
                  MaterialPageRoute(builder: (context) => Noti())),
          Navigator(
              key: navKeys[4],
              onGenerateRoute: (settings) => MaterialPageRoute(
                  builder: (context) =>
                      Profile(toggleDrawer: widget.toggleDrawer))),
        ],
      ),
      bottomNavigationBar: SizeTransition(
        sizeFactor: _hide,
        // forAnimation axisAlignment: 1,
        child: BottomNavigationBar(
          onTap: (index) => navigateTo(context, index),
          currentIndex: Provider.of<BottomNavBar>(context).getCurrentIndex,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'Create post',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_rounded),
              label: 'Activities',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'User profile',
            ),
          ],
        ),
      ),
    );
  }
}

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$kAppName',
          style: TextStyle(
            color: Color(0xff1477f8),
            fontWeight: FontWeight.w700,
            letterSpacing: 1.6,
          ),
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 12),
            icon: SvgPicture.asset(
              resourceHelper[10],
              alignment: Alignment.bottomCenter,
              width: 24,
              color: Theme.of(context).textTheme.headline4.color,
            ),
            tooltip: 'Open chats',
            onPressed: () {
              pageController.nextPage(
                duration: Duration(milliseconds: 350),
                curve: Curves.easeOut,
              );
            },
          ),
        ],
        // backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      backgroundColor: context.watch<MyTheme>().currentTheme == MyTheme.myLight
          ? Colors.white
          : Colors.black,
      body: ListView(
        children: [
          Container(
            height: 115,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (c, index) =>
                  index == 0 ? PostStory() : Story(index - 1),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: 10,
            itemBuilder: (context, index) => APost(index + 500),
          ),
        ],
      ),
    );
  }
}

class PostStory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateTo(context, 2),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 8, 0),
        child: Column(
          children: [
            Container(
              width: 78,
              height: 78,
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                fit: StackFit.expand,
                children: [
                  circularImg('https://picsum.photos/id/1000/100', 78),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      maxRadius: 13,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.add,
                        size: 22,
                        color: Color(0xff1477f8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text('My story'),
            ),
          ],
        ),
      ),
    );
  }
}

class Story extends StatefulWidget {
  final int index;
  Story(this.index);
  @override
  _StoryState createState() => _StoryState();
}

class _StoryState extends State<Story>
// with TickerProviderStateMixin
{
  bool isLoad = false;

  // AnimationController animationController;
  // @override void initState() {  super.initState(); animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 2500));animationController.repeat(); }
  // @override void dispose() { animationController.dispose();super.dispose();}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
        width: 85,
        child: Column(
          children: [
            Container(
              width: 82,
              height: 82,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  widget.index > 5
                      ? CircularProgressIndicator(
                          value: isLoad ? null : 100,
                          strokeWidth: 3.5,
                          valueColor: AlwaysStoppedAnimation(
                            Colors.blueGrey[200],
                          ),
                        )
                      : ShaderMask(
                          shaderCallback: (bounds) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              colors: [
                                Colors.deepPurpleAccent[400],
                                Colors.deepPurpleAccent[200],
                                Color(0xcf1477f8),
                                Colors.white,
                              ],
                            ).createShader(bounds);
                          },
                          child: CircularProgressIndicator(
                            value: isLoad ? null : 100,
                            strokeWidth: 3.5,
                            valueColor: AlwaysStoppedAnimation(
                              Colors.blueAccent[700],
                            ),
                            //  animationController.drive(ColorTween( begin: Color(0xff1477f8), end: Colors.blue[300], )),
                          ),
                        ),
                  Hero(
                    transitionOnUserGestures: true,
                    tag: 'toStory${widget.index}',
                    child: GestureDetector(
                      onTap: () {
                        setState(() => isLoad = true);
                        Future.delayed(Duration(milliseconds: 460), () {
                          Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      StorySwipe(widget.index)));
                          Future.delayed(Duration(milliseconds: 300),
                              () => setState(() => isLoad = false));
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: context.watch<MyTheme>().currentTheme ==
                                        MyTheme.myLight
                                    ? Colors.blueGrey[100]
                                    : Colors.grey[800],
                                blurRadius: 8,
                                spreadRadius: 1.5,
                                offset: Offset(3, 3),
                              ),
                            ],
                          ),
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            fadeInDuration: Duration(milliseconds: 1),
                            fadeOutDuration: Duration(milliseconds: 1),
                            placeholder: AssetImage(resourceHelper[0]),
                            image: NetworkImage(
                                'https://picsum.photos/id/${widget.index + 10}/200'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                '${allAccounts[widget.index % 3 + 1][2]}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class APost extends StatefulWidget {
  final int index;
  APost(this.index);
  @override
  _APostState createState() => _APostState();
}

class _APostState extends State<APost> {
  bool isLiked = true, isBook = false, isMore = false;
  int imgCount = Random().nextInt(5) + 1;
  PageController imgControl;
  @override
  void initState() {
    super.initState();
    imgControl = PageController();
  }

  @override
  void dispose() {
    imgControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: context.watch<MyTheme>().currentTheme == MyTheme.myLight
              ? Colors.white
              : Colors.black,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: context.watch<MyTheme>().currentTheme == MyTheme.myLight
                  ? Colors.grey[300]
                  : Colors.grey[800],
              // blurRadius: 3,
              spreadRadius: 1.1,
              // offset: Offset(1.6, 1.2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
                  child: circularImg('https://picsum.photos/id/525/150', 44),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${allAccounts[widget.index % 4][1]}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline5),
                      Text('London',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline6),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                  color: Theme.of(context).textTheme.headline6.color,
                  splashRadius: 1,
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                if (!isLiked)
                  setState(() {
                    isLiked = true;
                  });
              },
              child: Container(
                width: screenW - 20,
                height: screenW - 20,
                child: PageView.builder(
                  clipBehavior: Clip.hardEdge,
                  controller: imgControl,
                  scrollDirection: Axis.horizontal,
                  itemCount: imgCount,
                  itemBuilder: (context, idx) {
                    return PinchZoom(
                      // only zooming inside parent
                      zoomEnabled: false,
                      //  thus disabling
                      zoomedBackgroundColor: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.7),
                      image: FadeInImage(
                        fit: BoxFit
                            .contain, // to show img without crop - contain
                        placeholder: AssetImage(resourceHelper[1]),
                        image: NetworkImage(
                            'https://picsum.photos/id/${widget.index + idx * idx}/600'),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (imgCount > 1)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ScrollingPageIndicator(
                    controller: imgControl,
                    itemCount: imgCount,
                    dotSelectedColor: Color(0xff1477f8),
                    dotSelectedSize: 8,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                children: [
                  IconButton(
                    icon: isLiked
                        ? Icon(Icons.favorite_rounded)
                        : Icon(Icons.favorite_border_rounded),
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                    splashRadius: 1,
                    color: isLiked
                        ? Colors.redAccent
                        : Theme.of(context).textTheme.headline4.color,
                    iconSize: 34,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (context) => CommentPage(),
                        ),
                      );
                    },
                    child: SvgPicture.asset(
                      resourceHelper[11],
                      alignment: Alignment.bottomCenter,
                      width: 26.8,
                      color: Theme.of(context).textTheme.headline4.color,
                    ),
                  ),
                  SizedBox(width: 9),
                  SvgPicture.asset(
                    resourceHelper[12],
                    alignment: Alignment.bottomCenter,
                    width: 26.8,
                    color: Theme.of(context).textTheme.headline4.color,
                  ),
                  Spacer(),
                  IconButton(
                    icon: isBook
                        ? Icon(Icons.bookmark_rounded)
                        : Icon(Icons.bookmark_border_rounded),
                    onPressed: () {
                      onSave(mainContext);
                      setState(() {
                        isBook = !isBook;
                      });
                    },
                    splashRadius: 1,
                    iconSize: 30,
                    color: Theme.of(context).textTheme.headline4.color,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 14, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      '53 likes',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isMore = !isMore;
                      });
                    },
                    child: Text(
                      '''Yeah
I saw you dancing in a crowded room
You look so happy when I'm not with you
But then you saw me, caught you by surprise
A single teardrop falling from your eye
I don't know why I run away
I'll make you cry when I run away
You could have asked me why I broke your heart
You could've told me that you fell apart
But you walked past me like I wasn't there
And just pretended like you didn't care
I don't know why I run away
I'll make you cry when I run away
Take me back 'cause I wanna stay
Save your tears for another
Save your tears for another day
Save your tears for another day
So I made you think that I would always stay
I said some things that I should never say
Yeah, I broke your heart like someone did to mine
And now you won't love me for a second time
I don't know why I run away
Oh girl, I make you cry when I run away
Girl, take me back 'cause I wanna stay
Save your tears for another
I realize that I'm much too late
And you deserve someone better
Save your tears for another day (ooh, yeah)
Save your tears for another day (yeah)
I don't know why I run away
I'll make you cry when I run away
Save your tears for another day, ooh girl (ah)
I said save your tears for another day, yeah (ah)
Save your tears for another day (ah)
Save your tears for another day (ah)''',
                      maxLines: isMore ? null : 2,
                      overflow: isMore ? null : TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  String text = '';
  var con = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Comments',
          style:
              Theme.of(context).textTheme.headline5.copyWith(letterSpacing: 1),
        ),
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 7,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: circularImg(
                          'https://picsum.photos/id/${index % 4 + 525}/150',
                          40),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${allAccounts[index % 4][2]}',
                            style: Theme.of(context).textTheme.headline5,
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false,
                                applyHeightToLastDescent: true),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              'Laborum in sint labore incididunt ullamco non duis nostrud eu commodo nostrud fugiat.',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          TextField(
            maxLines: 5,
            minLines: 1,
            controller: con,
            style: Theme.of(context).textTheme.bodyText2,
            onChanged: (value) {
              value = value.trim();
              if (text.isEmpty ^ value.isEmpty) setState(() {});
              text = value;
            },
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(5, 4, 5, 4),
                child: circularImg('https://picsum.photos/id/525/150', 0),
              ),
              prefixIconConstraints:
                  BoxConstraints(minWidth: 72, maxHeight: 48),
              suffixIcon: Container(
                // doesnt matter
                height: 0,
                child: IconButton(
                  splashRadius: 1,
                  iconSize: 50,
                  icon: Text(
                    'Send',
                    style: TextStyle(
                      color: Colors.blue.withOpacity(text.isEmpty ? 0.4 : 1),
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              contentPadding: const EdgeInsets.all(16),
              hintText: 'Add a comment',
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
