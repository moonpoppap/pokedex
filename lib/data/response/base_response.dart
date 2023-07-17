class BaseResponse{
  late final int resultCode;
  late final String statusMessage;
  late final bool isSuccess;

  BaseResponse.fromJson(Map<String, dynamic> parsedJson){
    resultCode = int.parse(parsedJson['result_code']);
    statusMessage = parsedJson['message'];
    isSuccess = parsedJson['success'];
  }
}

class BaseResponseError{
  late final int resultCode;
  late final String statusMessage;
  late final bool isSuccess;
  late final dynamic dataError;


  BaseResponseError.fromJson(Map<String, dynamic> parsedJson){
    resultCode = int.parse(parsedJson['result_code']);
    statusMessage = parsedJson['message'];
    isSuccess = parsedJson['success'];

    if(parsedJson['error'] != null) dataError = parsedJson['error'];
  }
}

class AppFeedResponse<T>{
  final T valueFeed;
  final bool lastPage;
  final int numPage, countPage;

  AppFeedResponse({required this.valueFeed, required this.numPage, required this.lastPage, required this.countPage});
}