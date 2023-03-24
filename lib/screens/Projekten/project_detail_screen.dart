import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kika_storen/utils/helper_widgets.dart';
import 'package:kika_storen/widgets/Contacts/contact_details_output.dart';

import '../../models/project.dart';
import '../../widgets/Projekten/blinds_card.dart';

class ProjectDetailScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ProjectDetailScreen({required this.project});

  final Project project;
  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  late String endDate;
  @override
  void initState() {
    endDate = DateFormat('dd.MM.yyyy').format(widget.project.endDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                widget.project.name,
                style: const TextStyle(fontSize: 26),
              ),
            ),
            addVerticalSpace(12),
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                'Store(n):',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Card(
              // color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: widget.project.blinds
                      .map((blind) => BlindsCard(blind: blind))
                      .toList(),
                ),
              ),
            ),
            ContactDetailsOutput('Projekt Typ', widget.project.category),
            ContactDetailsOutput('Fällig', endDate),
            ContactDetailsOutput('Address', widget.project.address),
            ContactDetailsOutput('Notizen', widget.project.notes)
          ],
        ),
      ),
    );
  }
}
