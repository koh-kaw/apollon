import 'package:cloud_firestore/cloud_firestore.dart';

// firestoreのドキュメントを扱うクラスBookを作る。
class Beetle {
  late String name;
  late String image;
  // ドキュメントを扱うDocumentSnapshotを引数にしたコンストラクタを作る
  Beetle(DocumentSnapshot doc) {
    //　ドキュメントの持っているフィールド'title'をこのBookのフィールドtitleに代入
    name = doc['name'];
    image = doc['image'];
  }
  // Bookで扱うフィールドを定義しておく。
  //String title;
}
