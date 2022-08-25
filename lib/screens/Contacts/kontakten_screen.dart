import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kika_storen/screens/Contacts/add_contact_screen.dart';
import 'package:kika_storen/screens/Contacts/contacts_list_screen.dart';
import 'package:kika_storen/utils/helper_widgets.dart';

// class KontaktenScreen extends StatefulWidget {
//   const KontaktenScreen({Key? key}) : super(key: key);

//   static const routeName = '/Kontakte-screen';

//   @override
//   State<KontaktenScreen> createState() => _KontaktenScreenState();
// }

// class _KontaktenScreenState extends State<KontaktenScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         appBar: AppBar(
//           bottom: const TabBar(
//             tabs: [
//               Tab(text: 'Intern'),
//               Tab(text: 'Extern'),
//               Tab(text: 'Lieferanten'),
//               Tab(text: 'Kunden'),
//             ],
//           ),
//           title: const Text('Kontakten'),
//         ),
//         body: const TabBarView(
//           children: [
//             ContactsListScreen('Intern'),
//             ContactsListScreen('Extern'),
//             ContactsListScreen('Lieferanten'),
//             ContactsListScreen('Kunden'),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.of(context).pushNamed(AddContactScreen.routeName);
//           },
//           child: const Icon(Iconsax.add),
//         ),
//       ),
//     ));
//   }
// }

class KontaktenScreen extends StatefulWidget {
  const KontaktenScreen({Key? key}) : super(key: key);
  static const routeName = '/Kontakte-screen';

  @override
  _KontaktenScreenState createState() => _KontaktenScreenState();
}

class _KontaktenScreenState extends State<KontaktenScreen> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['full_name']),
              subtitle: Text(data['company']),
            );
          }).toList(),
        );
      },
    );
  }
}
