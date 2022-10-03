import 'package:cloud_firestore/cloud_firestore.dart';
import '../beetles/beetle.dart';
import 'package:flutter/cupertino.dart';

class BeetleModel extends ChangeNotifier {
  // ListView.builderで使うためのBookのList booksを用意しておく。
  List<Beetle> beetles = [];

  Future<void> fetchBeetles() async {
    // Firestoreからコレクション'books'(QuerySnapshot)を取得してdocsに代入。
    final docs = await FirebaseFirestore.instance.collection('beetles').get();

    // getter docs: docs(List<QueryDocumentSnapshot<T>>型)のドキュメント全てをリストにして取り出す。
    // map(): Listの各要素をBookに変換
    // toList(): Map()から返ってきたIterable→Listに変換する。
    final beetles = docs.docs.map((doc) => Beetle(doc)).toList();
    this.beetles = beetles;
    notifyListeners();
  }
}
