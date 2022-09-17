import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restoran_app/data/api/api_service.dart';
import 'package:restoran_app/data/response/resto_list_response.dart';

import 'api_services_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetch Api Restaurant', () {
    test('return an Restaurant if http call completes successfully', () async {
      final client = MockClient();
      when(client.get(Uri.parse(ApiService.baseUrl + ApiService.endpointList)))
          .thenAnswer((_) async => http.Response('{"restaurants":[]}', 200));
      expect(
          await ApiService(client).getListResponse(), isA<RestoListResponse>());
    });
    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse(ApiService.baseUrl + ApiService.endpointList)))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(ApiService(client).getListResponse(), throwsException);
    });
  });
}
