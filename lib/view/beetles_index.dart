import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/beetle_model.dart';

/*
class BeetlesIndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("次のページ"),
      ),
      body: Container(
        height: double.infinity,
        color: Colors.red,
      ),
    );
  }
}
*/

class BeetlesIndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<BeetleModel>(
        // createでfetchBooks()も呼び出すようにしておく。
        create: (_) => BeetleModel()..fetchBeetles(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('カブトムシ一覧'),
          ),
          body: Consumer<BeetleModel>(
            builder: (context, model, child) {
              // FirestoreのドキュメントのList booksを取り出す。
              final beetles = model.beetles;
              return ListView.builder(
                // Listの長さを先ほど取り出したbooksの長さにする。
                itemCount: beetles.length,
                // indexにはListのindexが入る。
                itemBuilder: (context, index) {
                  return ListTile(
                    //　books[index]でList booksのindex番目の要素が取り出せる。
                    leading: Image.network(beetles[index].image),
                    /*leading: Image(
                      image: FirebaseImage(beetles[index].image,
                          shouldCache:
                              true, // The image should be cached (default: True)
                          maxSizeBytes:
                              3000 * 1000, // 3MB max file size (default: 2.5MB)
                          cacheRefreshStrategy: CacheRefreshStrategy
                              .NEVER // Switch off update checking
                          ),
                      width: 100,
                    ),*/
                    title: Text(beetles[index].name),
                    //leading: Image.network(beetles[index].image));
                    //FirebaseImage(beetles[index].image).preCache();
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
