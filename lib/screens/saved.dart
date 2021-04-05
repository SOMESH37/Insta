import '../helper.dart';

class Saved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              splashRadius: 1,
              tooltip: 'Back to profile',
              alignment: Alignment.centerLeft,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Text(
                'Saved posts',
                style: Theme.of(context).textTheme.headline5.copyWith(letterSpacing: 1),
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 6,
        itemBuilder: (context, index) => Collections(index),
      ),
    );
  }
}
class Collections extends StatelessWidget {
  final idx;
  Collections(this.idx);
  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
      height: 230,
      decoration: BoxDecoration(
        color:  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
         if(context.watch<MyTheme>().currentTheme == MyTheme.myLight) BoxShadow(
            color: Colors.blue[50],
            blurRadius: 4,
            spreadRadius: 5,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Collection name',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    '9 posts',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                splashRadius: 1,
                tooltip: 'Open',
                color: Theme.of(context).textTheme.headline4.color,
                icon: Icon(Icons.arrow_forward),
                iconSize: 28,
                onPressed: () {},
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 9,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                    ),
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage(resourceHelper[1]),
                      image: NetworkImage('https://picsum.photos/id/${index+304 + 6*idx}/200'),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}