abstract class HttpState {
  void onStartRequest(String url, String method);

  void onEndRequest(String url, String method);

  void onErrorRequest(String url, String method);

  void onSuccesRequest(String url, String method);
}