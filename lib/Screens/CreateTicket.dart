import 'package:flutter/material.dart';
import 'package:notitia/Providers/AuthProvider.dart';
import 'package:notitia/Screens/MainAppScreen.dart';
import 'package:notitia/Screens/TicketsWorkScreen.dart';
import 'package:provider/provider.dart';
import 'package:notitia/Providers/ProjectProvider.dart';
import 'package:tasty_toast/tasty_toast.dart';
import '../utils.dart';

class CreateTicket extends StatefulWidget {
  static const routeName = "/createTicket";
  CreateTicket({Key? key}) : super(key: key);

  @override
  _CreateTicketState createState() => _CreateTicketState();
}

class _CreateTicketState extends State<CreateTicket> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, dynamic> ticketDataMap = {
    "ticketTitle": "",
    "ticketDesc": "",
    "assignedDev": "",
    "submittedDev": "",
    "ticketPriority": "",
    "ticketStatus": "",
    "ticketType": "",
  };

  void _submitCreateProject() async {
    try {
      bool isValid = _formKey.currentState!.validate();
      print(isValid);
      if (!isValid) {
        return;
      }
      _formKey.currentState!.save();

      final projectID = Provider.of<ProjectProvider>(context, listen: false)
          .getSelectedProjectID;
      final submittedDev =
          Provider.of<AuthProvider>(context, listen: false).getUserData.email;
      final userID =
          Provider.of<AuthProvider>(context, listen: false).getUserData.id;

      print(projectID);

      ticketDataMap["ticketPriority"] = priorityDrop;
      ticketDataMap["ticketStatus"] = ticketStatus;
      ticketDataMap["ticketType"] = ticketType;
      ticketDataMap["submittedDev"] = submittedDev;
      ticketDataMap["assignedDev"] = submittedDev;

      await Provider.of<ProjectProvider>(context, listen: false).createTicket(
        ticketDataMap,
        userID!,
        projectID,
      );

      showToast(context, "New project created!",
          textStyle: TextStyle(color: Colors.white),
          background: BoxDecoration(color: Colors.green),
          alignment: Alignment.bottomCenter,
          duration: Duration(seconds: 4));

      Navigator.of(context).pop();
      //     .push(MaterialPageRoute(
      //   builder: (ctx) => Ticketwork(),
      // ))
      //     .then((value) {
      //   setState(() async {
      //     await Provider.of<ProjectProvider>(context)
      //         .getProjectDetails(projectID);
      //   });
      // });
    } catch (e) {
      showToast(context, "An Error occured, please try again",
          textStyle: TextStyle(color: Colors.white),
          background: BoxDecoration(color: Colors.green),
          alignment: Alignment.bottomCenter,
          duration: Duration(seconds: 4));
      print(e);
    }
  }

  String priorityDrop = "Low";
  String ticketType = "Feature request";
  String ticketStatus = "Open";

  List<String> priorities = ["High", "Moderate", "Low"];
  List<String> types = ["Feature request", "Bug", "Error"];
  List<String> status = ["Open", "Closed"];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Create New Project"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLength: 30,
                        decoration: InputDecoration(labelText: "Ticket Title "),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter a ticket name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          ticketDataMap['ticketTitle'] = value!;
                        },
                      ),
                      TextFormField(
                        maxLines: 5,
                        maxLength: 200,
                        decoration: InputDecoration(
                          labelText: "Ticket Description",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' please enter  a ticket description';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          ticketDataMap["ticketDesc"] = value!;
                          // projectDataMap['projectStage'] =
                          //     _option.toShortString();
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Ticket priority",
                          style: TextStyle(
                              fontSize: 20, color: convertToHex("#06512C")),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: DropdownButton(
                          value: priorityDrop,
                          items: priorities
                              .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  ))
                              .toList(),
                          onChanged: (String? value) {
                            setState(() {
                              priorityDrop = value!;
                            });
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Ticket Type",
                          style: TextStyle(
                              fontSize: 20, color: convertToHex("#06512C")),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: DropdownButton(
                          value: ticketType,
                          items: types
                              .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  ))
                              .toList(),
                          onChanged: (String? value) {
                            setState(() {
                              ticketType = value!;
                            });
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Ticket Status",
                          style: TextStyle(
                              fontSize: 20, color: convertToHex("#06512C")),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: DropdownButton(
                          value: ticketStatus,
                          items: status
                              .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  ))
                              .toList(),
                          onChanged: (String? value) {
                            setState(() {
                              ticketStatus = value!;
                            });
                          },
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _submitCreateProject();
                          },
                          child: Text("Create Project"),
                          style: ElevatedButton.styleFrom(
                            primary: primCol,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
