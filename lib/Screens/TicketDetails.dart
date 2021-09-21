import 'package:flutter/material.dart';
import 'package:notitia/Providers/ProjectProvider.dart';
import 'package:provider/provider.dart';

class TicketDetails extends StatefulWidget {
  static const routeName = "/ticketDetails";
  TicketDetails({Key? key}) : super(key: key);

  @override
  _TicketDetailsState createState() => _TicketDetailsState();
}

class _TicketDetailsState extends State<TicketDetails> {
  Map<String, String> dataMap = {"ticketStatus": ""};
  late Future<void> _fetchTicketData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchTicketData = _fetchTicket();
  }

  String? getTicketStatus() {
    return context.watch<ProjectProvider>().ticketDetails.ticketStatus;
  }

  late String? _ticketStatus = "Open";
  List<String> _ticketStatuses = ["Open", "Closed"];

  Future<void> _fetchTicket() async {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final id = arguments["id"];
    return Provider.of<ProjectProvider>(context).getTicket(id);
  }

  void updateTicket(String id) async {
    dataMap["ticketStatus"] = _ticketStatus!;
    await context.read<ProjectProvider>().updateTicket(id, dataMap);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final ticket = Provider.of<ProjectProvider>(context).ticketDetails;
    return FutureBuilder(
        future: _fetchTicketData,
        builder: (context, dataSnapShot) {
          return Scaffold(
            appBar: AppBar(title: Text("Ticket"), actions: [
              OutlinedButton(
                onPressed: _ticketStatus == ticket.ticketStatus
                    ? null
                    : () {
                        updateTicket(ticket.id!);
                      },
                child: Text(
                  "Update Ticket status",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
            body: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Ticket Title: ${ticket.ticketTitle}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Ticket Description: ${ticket.ticketDesc}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Current Ticket Status: ${ticket.ticketStatus}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButton(
                    value: _ticketStatus,
                    items: _ticketStatuses
                        .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _ticketStatus = value!;
                      });
                    },
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Ticket priotity: ${ticket.ticketPriority}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Ticket Type: ${ticket.ticketType}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Submitted By: ${ticket.submittedDev}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Assigned To: ${ticket.assignedDev}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
