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
