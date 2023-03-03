import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kika_storen/models/termin.dart';
import 'package:kika_storen/widgets/Terminen/termin_card.dart';

class EventItem extends StatelessWidget {
  final Termin event;
  final Function() onDelete;
  final Function()? onTap;
  const EventItem({
    Key? key,
    required this.event,
    required this.onDelete,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Slidable(
      //   endActionPane: ActionPane(motion: const StretchMotion(), children: [
      //     SlidableAction(
      //       icon: Icons.delete,
      //       onPressed: (context) async {
      //         await FirebaseFirestore.instance
      //             .collection('appointments')
      //             .doc(event.id)
      //             .delete();
      //       },
      //     )
      //   ]),
      child: Column(
        children: [
          // TerminCard(
          //   onTap: onTap,
          //   name: event.name,
          //   address: event.address,
          //   time: event.time,
          //   notes: event.notes,
          //   id: event.id,
          // ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            ),
            child: ListTile(
              title: Text(
                event.name,
              ),
              subtitle: Text(
                event.time,
              ),
              onTap: onTap,
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: onDelete,
              ),
            ),
          )
        ],
      ),
    );
  }
}
