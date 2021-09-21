import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:notitia/Providers/AuthProvider.dart';
import 'package:notitia/Providers/ProjectProvider.dart';
import 'package:notitia/Screens/CreateTicket.dart';
import 'package:notitia/Screens/TicketDetails.dart';
import 'package:notitia/utils.dart';
import 'package:provider/provider.dart';
import 'package:tasty_toast/tasty_toast.dart';

class TicketScreen extends StatefulWidget {
  static const routeName = "/ticketScreen";
  final String? projectID;

  const TicketScreen({this.projectID});

  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  bool _isLoading = false;

  String role = "Project Manager";
  final _formKey = GlobalKey<FormState>();
  List<String> roles = [
    "Project Lead",
    "Project Manager",
    "Developer",
    "Submitter"
  ];

  Map<String, String> dataMap = {
    "email": "",
    "role": "",
    "projectName": "testProject"
  };

  Future<void> addUserToProject() async {
    try {
      setState(() {
        _isLoading = true;
      });
      bool isFormValid = _formKey.currentState!.validate();

      if (!isFormValid) {
        return;
      }

      _formKey.currentState!.save();

      final providerData = Provider.of<ProjectProvider>(context, listen: false);
      String projectID = providerData.getSelectedProjectID;
      // String projectName = providerData.selectedProjectName;
      dataMap["role"] = role;
      print(dataMap);
      await providerData.inviteToProject(projectID, dataMap);
      setState(() {
        _isLoading = false;
      });
      showToast(context, "User added",
          textStyle: TextStyle(color: Colors.white),
          background: BoxDecoration(color: Colors.green),
          alignment: Alignment.bottomCenter,
          duration: Duration(seconds: 4));
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
      showToast(context, "An Error occured, please try again",
          textStyle: TextStyle(color: Colors.white),
          background: BoxDecoration(color: Colors.red),
          alignment: Alignment.bottomCenter,
          duration: Duration(seconds: 4));
    }
  }

  Color priorityColorGetter(String priority) {
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

  Future<void> addUserModal(BuildContext context) {
    return showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter mutate) {
            return SingleChildScrollView(
              child: Container(
                  child: Padding(
                padding: EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        "Add a user",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                          Icons.person_add,
                          color: primCol,
                        )),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter a username";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          dataMap["email"] = val!;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Select a role",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: DropdownButton(
                          value: role,
                          items: roles
                              .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  ))
                              .toList(),
                          onChanged: (String? value) {
                            mutate(() {
                              role = value!;
                            });
                          },
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            addUserToProject();
                          },
                          child: _isLoading
                              ? CircularProgressIndicator()
                              : Text("Add User"),
                          style: ElevatedButton.styleFrom(
                            primary: primCol,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ))
                    ],
                  ),
                ),
              )),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final tickets = Provider.of<ProjectProvider>(context).tickets;
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
                            itemBuilder: (ctx, i) => GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        TicketDetails.routeName,
                                        arguments: {"id": tickets[i].id});
                                  },
                                  child: Card(
                                    elevation: 2,
                                    child: ListTile(
                                      title: Text(tickets[i].ticketTitle!),
                                      trailing: Container(
                                        width: 10,
                                        height: 10,
                                        decoration: new BoxDecoration(
                                          color: priorityColorGetter(
                                              tickets[i].ticketPriority!),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      subtitle: Text(tickets[i].ticketType!),
                                    ),
                                  ),
                                ))),
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
                    arguments: {"id": widget.projectID}),
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
