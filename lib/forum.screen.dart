import 'package:ff2/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fireflutter/fireflutter.dart';

class ForumScreen extends StatefulWidget {
  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  String title = '';
  ForumData forum;

  // 무제한 스크롤은 ScrollController 로 감지하고
  // 스크롤이 맨 밑으로 될 때, Listener 핸들러를 실행한다.
  ScrollController scrollController =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);

  @override
  void initState() {
    title = Get.arguments['category'];
    forum = ForumData(
      category: Get.arguments['category'],
      render: (x) => setState(() => null), // Update loader
    );

    ff.fetchPosts(forum);

    /// Scroll event handler
    scrollController.addListener(() {
      // Check if the screen is scrolled to the bottom.
      var isEnd = scrollController.offset >
          (scrollController.position.maxScrollExtent - 200);
      // If yes, then get more posts.
      if (isEnd) ff.fetchPosts(forum);
    });

    super.initState();
  }

  @override
  void dispose() {
    forum.leave();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text('...'),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: forum.posts.length,
                  itemBuilder: (context, i) {
                    final post = forum.posts[i];

                    return Container(
                      margin: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Container(
                            color: Colors.grey[300],
                            padding: EdgeInsets.all(16),
                            child: ListTile(
                              title: Text(
                                post['title'] ?? '',
                                style: TextStyle(fontSize: 32),
                              ),
                              subtitle: Text(
                                post['content'] ?? '',
                                style: TextStyle(fontSize: 24),
                              ),
                              trailing: IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () => Get.toNamed('forumEdit',
                                      arguments: {'post': post})),
                            ),
                          ),
                          Row(
                            children: [
                              RaisedButton(
                                onPressed: () {},
                                child: Text('edit'),
                              ),
                              RaisedButton(
                                onPressed: () {},
                                child: Text('delete'),
                              ),
                              RaisedButton(
                                onPressed: () {},
                                child: Text('like'),
                              ),
                              RaisedButton(
                                onPressed: () {},
                                child: Text('dislike'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
              if (forum.inLoading) CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
