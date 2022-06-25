import 'package:flutter_test/flutter_test.dart';
import 'package:movieapp/src/core/models/movie_model.dart';

import 'mocks.dart';

void main(){
  TestWidgetsFlutterBinding.ensureInitialized();

  test('When update Database', () async {

    MockModel mock = MockModel();
    MockMovieDatabase database = MockMovieDatabase.instance;

    var didNotifyListeners = false;
    database.addListener(() => didNotifyListeners = true);
    final MockModel sample = mock;
    var result = await database.update(mock.movie);

    expect(result, 0);
    expect(didNotifyListeners, true);
  },skip: true);
}