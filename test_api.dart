import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  print('🔍 PROBANDO API DE RICK AND MORTY');
  print('=================================');

  // Probar conexión básica
  try {
    final response = await http.post(
      Uri.parse('https://rickandmortyapi.com/graphql'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'query': '''
          query {
            characters(page: 1) {
              results {
                name
                status
              }
            }
          }
        '''
      }),
    );

    print('📡 Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('✅ Respuesta exitosa!');
      print('📊 Data: ${data.keys}');

      if (data['data'] != null && data['data']['characters'] != null) {
        final characters = data['data']['characters']['results'];
        print('👥 Personajes encontrados: ${characters.length}');
        for (var char in characters.take(3)) {
          print('   - ${char['name']} (${char['status']})');
        }
      }
    } else {
      print('❌ Error: ${response.body}');
    }
  } catch (e) {
    print('❌ Excepción: $e');
  }

  print('\n🔍 PROBANDO API REST JSONPLACEHOLDER');
  print('=====================================');

  try {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts?userId=1'));

    print('📡 Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      final posts = jsonDecode(response.body);
      print('✅ Posts encontrados: ${posts.length}');
      for (var post in posts.take(3)) {
        print('   - ${post['title']}');
      }
    }
  } catch (e) {
    print('❌ Excepción: $e');
  }
}
