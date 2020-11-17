import '../helper.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  bool isPreview = false;
  int idx;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    'Search',
                    style: Theme.of(context).textTheme.headline5.copyWith(letterSpacing: 1),
                  ),
                  Spacer(),
                  Icon(
                    Icons.search_rounded,
                  ),
                ],
              ),
            ),
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          ),
          body: StaggeredGridView.countBuilder(
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            crossAxisCount: 3,
            staggeredTileBuilder: (index) => index % 18 == 0 || index % 18 == 10
                ? StaggeredTile.count(2, 2)
                : StaggeredTile.count(1, 1),
            // inkwell wont work with img and ink.image cant have fadeinimg :(
            itemBuilder: (context, index) => GestureDetector(
              onLongPressStart: (_) {
                idx = index;
                setState(() {
                  isPreview = true;
                });
              },
              onLongPressEnd: (details) {
                setState(() {
                  isPreview = false;
                });
              },
              onTap: () {},
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: AssetImage(
                    index % 18 == 0 || index % 18 == 10 ? resourceHelper[1] : resourceHelper[0]),
                image: NetworkImage('https://picsum.photos/id/${index + 263}/400'),
              ),
            ),
          ),
        ),
        if (isPreview) zoomImg(context, 'https://picsum.photos/id/${idx + 263}/400'),
      ],
    );
  }
}
