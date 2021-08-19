class User {
  String? id;
  String? username;
  String? email;
  String? profileImageUrl;
  bool? isAuthenticated;

  User(
      {this.id,
      this.username,
      this.email,
      this.profileImageUrl,
      this.isAuthenticated});
}

class Project {
  String projectId;
  String projectName;
  String projectDescription;
  String projectStage;
  String role;

  Project(
      {required this.projectId,
      required this.projectName,
      required this.projectDescription,
      required this.projectStage,
      required this.role});
}

class Ticket {
  String ticketTitle;
  String ticketDesc;
  String userId;
  String projectId;
  String? assignedDev;
  String submittedDev;
  String ticketPriority;
  String ticketStatus;
  String ticketType;

  Ticket(
      {required this.ticketTitle,
      required this.ticketDesc,
      required this.userId,
      required this.projectId,
      this.assignedDev,
      required this.submittedDev,
      required this.ticketPriority,
      required this.ticketStatus,
      required this.ticketType});
}

class OnBoardingElement {
  final String messageBig;
  final String message;
  final String iconUrl;
  OnBoardingElement(this.messageBig, this.message, this.iconUrl);
}

List<OnBoardingElement> onboardingData = [
  OnBoardingElement("Track  Projects", "Log and Record dev process in realtime",
      "assets/svg/workflow.svg"),
  OnBoardingElement("Collaborate  With Devs", "Interact with your dev team",
      "assets/svg/network.svg"),
  OnBoardingElement("Centralised  Planning", "All development in one place",
      "assets/svg/center.svg"),
];
