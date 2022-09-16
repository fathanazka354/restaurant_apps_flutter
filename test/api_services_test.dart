import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restoran_app/data/api/api_service.dart';
import 'package:restoran_app/data/response/resto_list_response.dart';

import 'api_services_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Fetch List Resto', () {
    test('test Is the Api can retrieved data', () async {
      final client = MockClient();
      when(client.get(Uri.parse(ApiService.baseUrl + ApiService.endpointList)))
          .thenAnswer((_) async => http.Response('{"restaurants":[]}', 200));
      expect(await ApiService().getListResponse(), isA<RestoListResponse>());
    });
  });
}
