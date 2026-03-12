import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:graphql_flutter/graphql_flutter.dart';
import '../models/character_model.dart';
import '../models/post_model.dart';

class APIService {
  static const String _graphQLEndpoint = 'https://rickandmortyapi.com/graphql';
  static const String _restBaseUrl = 'jsonplaceholder.typicode.com';

  late final GraphQLClient _graphQLClient;

  APIService() {
    final HttpLink httpLink = HttpLink(_graphQLEndpoint);
    _graphQLClient = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    );
  }

  Future<List<Character>> fetchCharacters() async {
    const String query = """
      query GetCharacters {
        characters(page: 1) {
          results {
            id
            name
            status
            species
            type
            gender
            image
            origin { name }
            location { name }
          }
        }
      }
    """;

    try {
      final options = QueryOptions(document: gql(query));
      final result = await _graphQLClient.query(options);

      if (result.hasException) {
        throw Exception('Error GraphQL: ${result.exception}');
      }

      final results = result.data?['characters']?['results'] as List?;

      if (results == null || results.isEmpty) {
        throw Exception('No se encontraron personajes');
      }

      return results.map((json) => Character.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Post>> fetchPostsForUser(int userId) async {
    try {
      final uri =
          Uri.https(_restBaseUrl, '/posts', {'userId': userId.toString()});
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Error HTTP: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Post>> fetchPostsForCharacter(Character character) async {
    return await fetchPostsForUser(character.simulatedUserId);
  }
}
