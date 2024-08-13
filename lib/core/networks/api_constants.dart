class ApiConstants {
  static const String serverIp = "172.20.10.7";
  static const String baseUrl = 'http://$serverIp:3006/api/';
  static const String login = 'login';
  static const String fetchZones = 'protected/FetchZones';
  static const String startShift = 'rider/StartShift';
  static const String closeShift = "rider/CloseShift";
  static const String getInfo = 'rider/info';
   static const String getOrders = "rider/FetchOrders";
  static const String claimOrder = "rider/ClaimOrder";
}
