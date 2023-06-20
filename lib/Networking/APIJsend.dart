class APIJsend {
  APIstatus apiStatus;
  var data;
  String message;

  APIJsend.name(
      {required this.apiStatus, required this.data, required this.message});
}

enum APIstatus { success, fail, error }
