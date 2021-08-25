import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:notitia/Providers/ProjectProvider.dart';
import 'package:notitia/Screens/CreateTicket.dart';
import 'package:notitia/utils.dart';
import 'package:provider/provider.dart';

class TicketScreen extends StatelessWidget {
  static const routeName = "/ticketScreen";
  final String? projectID;

  const TicketScreen({this.projectID});

  @override
  Widget build(BuildContext context) {
    final tickets = Provider.of<ProjectProvider>(context).tickets;
    print(tickets);
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Container(
              decoration: BoxDecoration(color: primCol),
              height: 40,
              child: const TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 5,
                tabs: [
                  Tab(
                    text: "All Issues",
                  ),
                  Tab(
                    text: "Open",
                  ),
                  Tab(text: "Closed issues"),
                ],
              ),
            ),
          ),
          body: tickets.length != 0
              ? TabBarView(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ListView.builder(
                            itemCount: tickets.length,
                            itemBuilder: (ctx, i) => issueItem(
                                ticketTitle: tickets[i].ticketTitle,
                                asignedDev: tickets[i].assignedDev,
                                submittedDev: tickets[i].submittedDev,
                                priority: tickets[i].ticketPriority,
                                ticketDesc: tickets[i].ticketDesc))),
                    Icon(Icons.directions_transit),
                    Icon(Icons.directions_bike),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Spacer(
                        flex: 2,
                      ),
                      Center(
                        child: Text(
                          "No Tickets in current project",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Center(
                        child: Text(
                          "select the add button to add a ticket",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Spacer(
                        flex: 4,
                      ),
                    ],
                  ),
                ),
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            animatedIconTheme: IconThemeData(size: 22.0),
            // this is ignored if animatedIcon is non null
            // child: Icon(Icons.add),
            visible: true,
            curve: Curves.bounceIn,
            overlayColor: Colors.black,
            overlayOpacity: 0.5,
            onOpen: () => print('OPENING DIAL'),
            onClose: () => print('DIAL CLOSED'),
            tooltip: 'Speed Dial',
            heroTag: 'speed-dial-hero-tag',
            backgroundColor: primCol,
            foregroundColor: Colors.white,
            elevation: 8.0,
            shape: CircleBorder(),
            children: [
              SpeedDialChild(
                foregroundColor: Colors.white,
                child: Icon(Icons.note_add),
                backgroundColor: primCol,
                labelStyle: TextStyle(fontSize: 18.0),
                label: "Add Ticket",
                onTap: () => Navigator.of(context).pushNamed(
                    CreateTicket.routeName,
                    arguments: {"id": projectID}),
              ),
              SpeedDialChild(
                foregroundColor: Colors.white,
                child: Icon(Icons.person_add),
                backgroundColor: primCol,
                label: 'Add User',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () => addUserModal(context),
              ),
            ],
          ),
        ));
  }
}

Future<void> addUserModal(BuildContext context) {
  return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
            child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                "Add a user",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(
                  Icons.person_add,
                  color: primCol,
                )),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.length < 2) {
                    return "please enter a username";
                  }
                  return null;
                },
              ),
            ],
          ),
        ));
      });
}

Widget issueItem({
  String? asignedDev,
  String? ticketDesc,
  String? submittedDev,
  String? ticketTitle,
  String? priority,
}) {
  Color priorityColorGetter() {
    Color color;
    if (priority == "Low") {
      return color = Colors.yellow;
    }
    if (priority == "Meduim") {
      return color = Colors.orange;
    }

    color = Colors.red;
    return color;
  }

  return Card(
    color: primCol,
    elevation: 7,
    child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Submitter: ${submittedDev!}",
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(ticketDesc!,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              )),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text("Assigned To: $submittedDev",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              Spacer(),
              Icon(
                Icons.label_important,
                color: priorityColorGetter(),
              )
            ],
          )
        ],
      ),
    ),
  );
}
