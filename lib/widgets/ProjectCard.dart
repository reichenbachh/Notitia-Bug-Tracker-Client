import 'package:flutter/material.dart';
import 'package:notitia/model_data.dart';
import '../utils.dart';

class ProjectCard extends StatelessWidget {
  final String projectName;
  final String projectStage;
  final String role;

  ProjectCard(
      {required this.projectName,
      required this.projectStage,
      required this.role});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: convertToHex("#06512C"),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 7.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  projectStage,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(projectName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings_applications_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                      Text(
                        role,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.group_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    Text(
                      "16",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
