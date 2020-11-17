import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';
import '../helper.dart';
import './story_swipe.dart';

AnimationController _hide;
PageController pageController = PageController(keepPage: true);
// Idea cancelled ;(
// NotificationListener( onNotification: (listen) {  if (listen is UserScrollNotification && listen.depth == 0 && (Provider.of<BottomNavBar>(context, listen: false).getCurrentIndex == 6)) {
//                 switch (listen.direction) {
//                   case ScrollDirection.forward:
//                     _hide.forward();
//                     break;
//                   case ScrollDirection.reverse:
//                     _hide.reverse();
//                     break;
//                   case ScrollDirection.idle:
//                     break;  }    } if (listen is OverscrollIndicatorNotification)   listen.disallowGlow();  return;   }, child: );

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return PageView(
          controller: pageController,
          children: [
            Home(),
            if (Provider.of<BottomNavBar>(context).getCurrentIndex == 0) Chat(),
          ],
        );
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin<Home> {
  @override
  void initState() {
    super.initState();
    _hide = AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    _hide.forward();
  }

  @override
  void dispose() {
    _hide.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        screenH = MediaQuery.of(context).size.height;
        screenW = MediaQuery.of(context).size.width;
        return Scaffold(
          body: IndexedStack(
            index: Provider.of<BottomNavBar>(context).getCurrentIndex,
            children: [
              Feed(),
              Explore(),
              CreatePost(Colors.blue),
              Noti(),
              Profile(),
            ],
          ),
          bottomNavigationBar: SizeTransition(
            sizeFactor: _hide,
            //forAnimation axisAlignment: 1,
            child: BottomNavigationBar(
              onTap: (index) {
                if (Provider.of<BottomNavBar>(context, listen: false).getCurrentIndex == index)
                  ;
                else
                  Provider.of<BottomNavBar>(context, listen: false).setCurrentIndex = index;
              },
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
      },
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
            padding: const EdgeInsets.only(right: 11),
            icon: Icon(Icons.chat_outlined),
            color: Colors.grey[600],
            splashRadius: 1,
            tooltip: 'Open chats',
            onPressed: () {
              pageController.nextPage(
                duration: Duration(milliseconds: 350),
                curve: Curves.easeOut,
              );
            },
          ),
        ],
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      body: ListView(
        children: [
          Container(
            height: 115,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (c, index) => index == 0 ? PostStory() : Story(index),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: 10,
            itemBuilder: (context, index) => APost(index),
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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StoryEditor(),
          ),
        );
      },
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
  bool isLoad = false, isSeen = Random().nextBool();

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
                  isSeen
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
                    tag: 'toStory${widget.index - 1}',
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isLoad = true;
                        });
                        Future.delayed(Duration(milliseconds: 600), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StorySwipe(
                                widget.index - 1,
                              ),
                            ),
                          );
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
                                color: Colors.blueGrey[100],
                                blurRadius: 8,
                                spreadRadius: 1.5,
                                offset: Offset(3, 3),
                              ),
                            ],
                          ),
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            placeholder: AssetImage(resourceHelper[0]),
                            image:
                                NetworkImage('https://picsum.photos/id/${widget.index + 10}/200'),
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
                'UserNameUnique',
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
  bool isLiked = false, isBook = false, isMore = false;
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey[100],
              blurRadius: 5,
              spreadRadius: -2,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
                  child: circularImg('https://picsum.photos/id/${400 + widget.index}/100', 44),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name ',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline5),
                      Text('Location',
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
            Container(
              width: screenW - 20,
              height: screenW - 20,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
              ),
              child: PageView.builder(
                controller: imgControl,
                scrollDirection: Axis.horizontal,
                itemCount: imgCount,
                itemBuilder: (context, idx) {
                  return PinchZoom(
                    zoomedBackgroundColor:
                        Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
                    image: FadeInImage(
                      fit: BoxFit.contain, // to show img without crop - contain
                      placeholder: AssetImage(resourceHelper[1]),
                      image: NetworkImage(
                          'https://picsum.photos/id/${widget.index + 500 + idx * idx}/600'),
                    ),
                  );
                },
              ),
            ),
            if (imgCount > 1)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ScrollingPageIndicator(
                  controller: imgControl,
                  itemCount: imgCount,
                  dotSelectedColor: Color(0xff1477f8),
                  dotSelectedSize: 8,
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
                    color: isLiked ? Colors.redAccent : Theme.of(context).textTheme.headline4.color,
                    iconSize: 34,
                  ),
                  IconButton(
                    icon: Icon(Icons.cloud_queue_rounded),
                    onPressed: () {},
                    splashRadius: 1,
                    iconSize: 34,
                    color: Theme.of(context).textTheme.headline4.color,
                  ),
                  Spacer(),
                  IconButton(
                    icon:
                        isBook ? Icon(Icons.bookmark_rounded) : Icon(Icons.bookmark_border_rounded),
                    onPressed: () {
                      onSave(context);
                      setState(() {
                        isBook = !isBook;
                      });
                    },
                    splashRadius: 1,
                    iconSize: 34,
                    color: Theme.of(context).textTheme.headline4.color,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      '${Random().nextInt(1000)} likes',
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
                      '''Cillum adipisicing irure nisi aliquip sunt id veniam tempor commodo ea in magna voluptate. Culpa ex fugiat consequat id tempor qui sit et aute non commodo duis aliqua consectetur. Mollit id magna eu dolore velit pariatur adipisicing ea eu consequat. Adipisicing in pariatur nisi veniam amet sint anim fugiat deserunt. Ad qui voluptate consectetur elit irure reprehenderit nulla mollit magna laborum. Mollit anim non enim laboris commodo id deserunt sit aliqua nostrud ea sunt aute.

Ipsum cupidatat fugiat veniam adipisicing sint. Sint labore fugiat laborum dolore. Cupidatat commodo sunt aute officia veniam sit enim commodo adipisicing adipisicing reprehenderit et nisi.

Aliqua elit anim do nulla do reprehenderit ut reprehenderit commodo nulla. Tempor ut cupidatat cupidatat aute enim esse. Do sit ad nisi nisi sit Lorem non aute deserunt officia quis laboris. Excepteur laborum sit nostrud laboris ea esse adipisicing aliquip commodo voluptate fugiat. Elit occaecat eu qui aute ad amet quis sit consectetur. Laboris cupidatat magna nisi ullamco aliquip esse adipisicing ipsum laboris Lorem et pariatur nostrud velit.

Excepteur qui Lorem qui non ullamco eu amet velit laborum irure amet Lorem anim. Proident quis sint aliquip id do occaecat exercitation cupidatat non velit ipsum qui esse. Irure excepteur aliqua ex reprehenderit ex. Laboris proident ipsum ullamco culpa laborum ad culpa velit tempor officia ad laboris. Sint consectetur sunt exercitation excepteur id. Velit eu eiusmod pariatur mollit est aute nisi dolor.''',
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
