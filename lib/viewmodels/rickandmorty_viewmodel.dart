import 'package:flutter/material.dart';
import '../models/character_model.dart';
import '../models/post_model.dart';
import '../services/api_service.dart';

class RickAndMortyViewModel extends ChangeNotifier {
  List<Character> _characters = [];
  List<Post> _currentPosts = [];
  Character? _selectedCharacter;
  String? _errorMessage;
  bool _isLoading = false;
  bool _isLoadingPosts = false;

  List<Character> get characters => _characters;
  List<Post> get currentPosts => _currentPosts;
  Character? get selectedCharacter => _selectedCharacter;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isLoadingPosts => _isLoadingPosts;

  final APIService _apiService = APIService();

  Future<void> loadCharacters() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _characters = await _apiService.fetchCharacters();
    } catch (e) {
      _errorMessage = 'Error al cargar personajes: ${e.toString()}';
      _characters = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadCharacterPosts(Character character) async {
    _selectedCharacter = character;
    _isLoadingPosts = true;
    _currentPosts = [];
    _errorMessage = null;
    notifyListeners();

    try {
      _currentPosts = await _apiService.fetchPostsForCharacter(character);
    } catch (e) {
      _errorMessage = 'Error al cargar posts: ${e.toString()}';
    } finally {
      _isLoadingPosts = false;
      notifyListeners();
    }
  }

  void clearSelection() {
    _selectedCharacter = null;
    _currentPosts = [];
    notifyListeners();
  }

  Future<void> refreshData() async {
    clearSelection();
    await loadCharacters();
  }
}
