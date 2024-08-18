class ApiConstants {
  static const String serverIp = "localhost";
  static const String baseUrl = 'http://$serverIp:3006/api/';
  static const String login = 'login';
  static const String fetchHubs = 'protected/FetchHubs';
  static const String startShift = 'rider/StartShift';
  static const String closeShift = "rider/CloseShift";
  static const String getInfo = 'rider/info';
  static const String getOrders = "rider/FetchOrders";
  static const String claimOrder = "rider/ClaimOrder";
  static const String getCurrentOrder = "rider/FetchCurrentOrder";
  static const String closeOrder = "rider/CloseOrder";
  static const String orderSse = "rider/OrdersSSE";
}
