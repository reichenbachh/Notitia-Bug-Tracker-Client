class User {
  String? id;
  String? username;
  String? email;
  String? profileImageUrl;
  bool? isAuthenticated;
  String? role;

  User(
      {this.id,
      this.username,
      this.email,
      this.profileImageUrl,
      this.isAuthenticated,
      this.role});
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
  String? id;
  String? ticketTitle;
  String? ticketDesc;
  String? userId;
  String? projectId;
  String? assignedDev;
  String? submittedDev;
  String? ticketPriority;
  String? ticketStatus;
  String? ticketType;

  Ticket(
      {this.id,
      this.ticketTitle,
      this.ticketDesc,
      this.userId,
      this.projectId,
      this.assignedDev,
      this.submittedDev,
      this.ticketPriority,
      this.ticketStatus,
      this.ticketType});
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
