// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final user = FirebaseAuth.instance.currentUser!;
//
//   //document ids
//   List<String> docIds = [];
//
//   Future getDocId() async {
//     await FirebaseFirestore.instance
//         .collection('users')
//         .orderBy('age' , descending: false)  //where()
//         .get()
//         .then((snapshot) => snapshot.docs.forEach((element) {
//               docIds.add(element.reference.id);
//             }));
//   }
//
//   // @override
//   // void initState() {
//   //   getDocId();
//   //   super.initState();
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('signed in ${user.email!}'),
//         actions: [
//           GestureDetector(
//             onTap: (){ FirebaseAuth.instance.signOut();
//     },
//               child: Icon(Icons.login_outlined))
//         ],
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//
//
//
//
//
//
//
//           Expanded(
//             child: FutureBuilder(
//               future: getDocId(),
//               builder: (context, snapshot) {
//                 return ListView.builder(
//                   itemCount: docIds.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ListTile(
//                       //  title: GetUserName(documentId: docIds[index]),
//                         tileColor: Colors.grey[100],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
