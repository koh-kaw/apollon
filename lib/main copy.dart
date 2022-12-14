import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'view/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'テスト',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyAuthPage(),
    );
  }
}

class MyAuthPage extends StatefulWidget {
  @override
  _MyAuthPageState createState() => _MyAuthPageState();
}

class _MyAuthPageState extends State<MyAuthPage> {
  // 入力されたユーザーの名前
  String newUser = "";
  // 入力されたメールアドレス
  String newUserEmail = "";
  // 入力されたパスワード
  String newUserPassword = "";
  // 登録・ログインに関する情報を表示
  String infoText = "";
  // FireStoreにユーザー情報を登録する関数を定義
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> Register() {
    // 上で定義したメンバ変数を格納すると、usersコレクションに、
    // メールアドレスとパスワードも保存できる。
    return users
        .add({
          'name': newUser,
          'email': newUserEmail,
          'password': newUserPassword
        })
        .then((value) => print("新規登録に成功"))
        .catchError((error) => print("新規登録に失敗しました!: $error"));
  }

  // メールアドレスとパスワードを登録する関数を定義
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> createAuth() async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
      email: newUserEmail,
      password: newUserPassword,
    );
    final User user = result.user!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ユーザー登録'),
      ),
      // キーボードで隠れて、黄色エラーが出るので
      // SingleChildScrollViewで、Centerウイジットをラップする
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // かっこよくしたいので、画像を配置した!
                const CircleAvatar(
                  radius: 75,
                  // images.unsplash.comの画像のパスを貼り付ける
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1658033014478-cc3b36e31a5e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMDR8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60'),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  // テキスト入力のラベルを設定
                  decoration: InputDecoration(labelText: "ユーザー名"),
                  onChanged: (String value) {
                    setState(() {
                      newUser = value;
                    });
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  // テキスト入力のラベルを設定
                  decoration: InputDecoration(labelText: "メールアドレス"),
                  onChanged: (String value) {
                    setState(() {
                      newUserEmail = value;
                    });
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(labelText: "パスワード（６文字以上）"),
                  // パスワードが見えないようにする
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() {
                      newUserPassword = value;
                    });
                  },
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      // FireStoreにユーザー情報を登録する関数
                      Register();
                      // メール/パスワードでユーザー登録
                      createAuth();
                      // 登録したユーザー情報
                    } catch (e) {
                      // 登録に失敗した場合
                      setState(() {
                        infoText = "登録NG:${e.toString()}";
                      });
                    }
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Home();
                    }));
                  },
                  child: Text("ユーザー登録"),
                ),
                const SizedBox(height: 8),
                Text(infoText)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
