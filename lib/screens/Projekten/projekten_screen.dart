import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kika_storen/screens/Projekten/project_list_screen.dart';

import '../../services/firestore_service.dart';

class ProjektenScreen extends StatelessWidget {
  ProjektenScreen({Key? key}) : super(key: key);

  static const routeName = '/Projekten-screen';
  final firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                labelPadding: EdgeInsets.all(0),
                tabs: [
                  Tab(text: 'Montage'),
                  Tab(text: 'Reparatur'),
                  Tab(text: 'Beratung'),
                ],
              ),
              title: const Text('Projekten'),
            ),
            body: TabBarView(
              children: [
                ProjectListScreen('Montage'),
                ProjectListScreen('Reparatur'),
                ProjectListScreen('Beratung'),
              ],
            ),
            // StreamBuilder<QuerySnapshot>(
            //   stream: firestoreService.getProjects(),
            //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // if (snapshot.hasError) {
            //   return const Text('Something went wrong');
            // }

            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return const Center(child: Text("Lade"));
            // }
            // if (!snapshot.hasData) {
            //   return const Center(
            //     child: Text('Keine Kontakte'),
            //   );
            // }

            // return ListView(
            //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
            //     Map<String, dynamic> data =
            //         document.data()! as Map<String, dynamic>;
            //     print(data);
            //     return Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 14),
            //       child: Dismissible(
            //         key: const Key(''),
            //         onDismissed: (direction) {
            //           firestoreService.deleteContact();
            //         },
            //         child: Row(
            //           children: [
            //             Column(
            //               children: const [
            //                 Icon(Icons.assignment),
            //               ],
            //             ),
            //             Expanded(
            //               child: Column(
            //                 children: [
            //                   GestureDetector(
            //                     onTap: () {
            //                       // Navigator.of(context).pushNamed(
            //                       //     ContactDetailScreen.routeName,
            //                       //     arguments: data);
            //                     },
            //                     child: ListTile(
            //                       title: Text(data['name']),
            //                     ),
            //                   )
            //                 ],
            //               ),
            //             ),
            //             Column(
            //               children: [
            //                 // GestureDetector(
            //                 //   child: const Icon(Icons.call),
            //                 //   onTap: () async {
            //                 //     final Uri url =
            //                 //         Uri(scheme: 'tel', path: data['mobil']);
            //                 //     if (await canLaunchUrl(url)) {
            //                 //       await launchUrl(url);
            //                 //     } else {
            //                 //       return;
            //                 //     }
            //                 //   },
            //                 // )
            //               ],
            //             )
            //           ],
            //         ),
            //       ),
            //     );
            //   }).toList(),
            // );
            //   },
            // ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/Add-projekt-screen');
              },
              child: Icon(Icons.add),
            )),
      ),
    );
  }
}
