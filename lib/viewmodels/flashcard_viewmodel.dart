import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/flashcard.dart';

class FlashcardViewModel extends ChangeNotifier {
  static const _storageKey = 'flashcards_v1';
  final _uuid = const Uuid();

  List<Flashcard> _cards = [];
  bool _isLoading = true;

  List<Flashcard> get cards => List.unmodifiable(_cards);
  bool get isLoading => _isLoading;
  int get cardCount => _cards.length;

  FlashcardViewModel() {
    _loadCards();
  }

  Future<void> _loadCards() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw != null) {
      final list = jsonDecode(raw) as List;
      _cards = list.map((e) => Flashcard.fromJson(e)).toList();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _saveCards() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(_cards.map((c) => c.toJson()).toList());
    await prefs.setString(_storageKey, raw);
  }

  Future<void> addCard(String question, String answer) async {
    final card = Flashcard(
      id: _uuid.v4(),
      question: question.trim(),
      answer: answer.trim(),
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    _cards.add(card);
    notifyListeners();
    await _saveCards();
  }

  Future<void> editCard(String id, String question, String answer) async {
    final idx = _cards.indexWhere((c) => c.id == id);
    if (idx == -1) return;
    _cards[idx] = _cards[idx].copyWith(
      question: question.trim(),
      answer: answer.trim(),
    );
    notifyListeners();
    await _saveCards();
  }

  Future<void> deleteCard(String id) async {
    _cards.removeWhere((c) => c.id == id);
    notifyListeners();
    await _saveCards();
  }
}
