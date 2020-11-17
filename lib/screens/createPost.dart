import '../helper.dart';

class CreatePost extends StatefulWidget {
  var myColor;
  CreatePost(this.myColor);
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1500,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [widget.myColor, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: ListView.builder(
          padding: EdgeInsets.only(left: 300),
          itemBuilder: (c, index) => Text('$index'),
        ),
      ),
    );
  }
}
