import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kika_storen/screens/Projekten/project_edit_screen.dart';

import '../../services/firestore_service.dart';
import '../../utils/helper_widgets.dart';

class ProjectListScreen extends StatelessWidget {
  ProjectListScreen(this.category);
  final String category;
  final firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getProjects(category),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Lade"));
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text('Keine Kontakte'),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Slidable(
                  endActionPane:
                      ActionPane(motion: const StretchMotion(), children: [
                    SlidableAction(
                      backgroundColor: Colors.red,
                      onPressed: (context) {
                        firestoreService.deleteProject(data['id']);
                        showToast('Projekt erfolgreich gelöscht');
                      },
                      icon: Icons.delete,
                    )
                  ]),
                  child: Row(
                    children: [
                      Column(
                        children: const [
                          Icon(Icons.assignment),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push<bool>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ProjectEditScreen(data),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(data['name']),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
