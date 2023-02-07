import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kika_storen/screens/Terminen/add_termin_screen.dart';
import 'package:kika_storen/widgets/Terminen/card.dart';

import '../../services/firestore_service.dart';

class TerminenListScreen extends StatelessWidget {
  TerminenListScreen({this.date});

  final firestoreService = FirestoreService();
  final date;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getAppointments(date),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text("Lade"));
        }
        if (!snapshot.hasData) {
          return const Center(
            child: Text('Keine Termine'),
          );
        }

        return Expanded(
          child: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            AddTerminScreen.routeName,
                            arguments: data);
                      },
                      child: TerminCard(
                        name: data['name'],
                        address: data['address'],
                        time: data['time'],
                        notes: data['notes'],
                      ),
                      // child: Text(data['name']),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
