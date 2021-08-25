import 'package:flutter/material.dart';
import 'package:notitia/Providers/ProjectProvider.dart';
import 'package:notitia/Screens/CommScreen.dart';
import 'package:notitia/Screens/TicketsScreen.dart';
import 'package:notitia/utils.dart';
import 'package:provider/provider.dart';

class Ticketwork extends StatefulWidget {
  static const routeName = "/workScreen";
  final projectID;
  Ticketwork({this.projectID});
  @override
  _TicketworkState createState() => _TicketworkState();
}

class _TicketworkState extends State<Ticketwork> {
  late Future<void> _fetchTicketData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchTicketData = _fetchTicket();
  }

  Future<void> _fetchTicket() async {
    String id = widget.projectID;
    return Provider.of<ProjectProvider>(context).getProjectDetails(id);
  }

  Widget returnBody(int index) {
    List<Widget> widgetOption = <Widget>[TicketScreen(), CommScreen()];

    return widgetOption.elementAt(index);
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchTicketData,
      builder: (context, dataSnapShot) {
        if (dataSnapShot.connectionState == ConnectionState.waiting) {
          print(dataSnapShot.connectionState);
          return SafeArea(
              child: Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              backgroundColor: primCol,
            )),
          ));
        }
        return Consumer<ProjectProvider>(builder: (contex, data, child) {
          return Container(
            child: Scaffold(
              appBar: AppBar(
                title: Text(data.selectedProjectName),
                centerTitle: true,
              ),
              body: returnBody(_selectedIndex),
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.bug_report),
                    label: 'Tickets',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.forum),
                    label: 'Communications',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.green[800],
                onTap: _onItemTapped,
              ),
            ),
          );
        });
      },
    );
  }
}
