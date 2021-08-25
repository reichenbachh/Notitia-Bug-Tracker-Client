import 'package:flutter/material.dart';
import 'package:notitia/Providers/ProjectProvider.dart';
import 'package:notitia/utils.dart';
import 'package:provider/provider.dart';

class TicketDetails extends StatefulWidget {
  TicketDetails({Key? key}) : super(key: key);

  @override
  _TicketDetailsState createState() => _TicketDetailsState();
}

class _TicketDetailsState extends State<TicketDetails> {
  late Future<void> _fetchTicketData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchTicketData = _fetchTicket();
  }

  Future<void> _fetchTicket() async {
    // String id = widget.projectID;
    // return Provider.of<ProjectProvider>(context).getProjectDetails(id);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, dataSnapshot) {
      if (dataSnapshot.connectionState == ConnectionState.waiting) {
        return SafeArea(
            child: Scaffold(
          body: Center(
              child: CircularProgressIndicator(
            backgroundColor: primCol,
          )),
        ));
      }

      return Container();
    });
  }
}
