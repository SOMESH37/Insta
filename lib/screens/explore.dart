import '../helper.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                'Search',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(letterSpacing: 1),
              ),
              Spacer(),
              Icon(
                Icons.search_rounded,
              ),
            ],
          ),
        ),
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        crossAxisCount: 3,
        staggeredTileBuilder: (index) => index % 18 == 0 || index % 18 == 10
            ? StaggeredTile.count(2, 2)
            : StaggeredTile.count(1, 1),
        itemBuilder: (context, index) => Stack(
          children: [
            FadeInImage(
              fit: BoxFit.cover,
              placeholder: AssetImage(index % 18 == 0 || index % 18 == 10
                  ? resourceHelper[1]
                  : resourceHelper[0]),
              image:
                  NetworkImage('https://picsum.photos/id/${index + 263}/600'),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  child: GestureDetector(
                    onLongPressStart: (_) {
                      currentPreviewImgUrl =
                          'https://picsum.photos/id/${index + 263}/600';
                      isPreview.sink.add(true);
                    },
                    onLongPressEnd: (details) {
                      isPreview.sink.add(false);
                    },
                  ),
                  onTap: () {
                    pushThePost(context, index + 263);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void pushThePost(BuildContext context, int index) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: APost(index),
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    ),
  );
}
