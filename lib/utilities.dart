class Utilities {
  printLog(String data) {
    print(
        '\n************************* IHK Log  at :'+DateTime.now().toString()+' ****************\n');

    // print(DateTime.now().toIso8601String());
    print('\n $data');
    print(
        '\n**************************************************************************************\n');
  }
}
