class AppFeed<T>{
  int? _countPage;
  int? _numPage;
  bool? _lastPage;
  List<T>? _feed;

  AppFeed({int countPage = 0, int? numPage, bool? lastPage, List<T>? feed}){
    _countPage = countPage;
    _numPage = numPage;
    _lastPage = lastPage;
    _feed = feed;
  }

  int get countPage => _countPage!;
  int get numPage => _numPage!;
  bool get lastPage => _lastPage!;
  List<T> get feed => _feed!;

  set countPage(int countPage)=> _countPage = countPage;

  set numPage(int numPage)=> _numPage = numPage;

  set lastPage(bool lastPage)=> _lastPage = lastPage;

  set feed(List<T> feed)=> _feed = feed;
}