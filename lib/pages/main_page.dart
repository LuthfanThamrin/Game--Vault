import 'package:flutter/material.dart';
import 'package:game_vault/model/game.dart';
import 'package:game_vault/pages/detail_page.dart';
import 'package:game_vault/pages/favorites_tab.dart';
import 'package:game_vault/pages/home_tab.dart';
import 'package:game_vault/pages/library_tab.dart';
import 'package:game_vault/service/game_service.dart';
import 'package:game_vault/widgets/message_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Game> _games = [];
  bool _isLoading = true;
  String? _errorMessage; // null = tidak ada error
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadGames(); // dipanggil sekali saat halaman dibuat
  }

  
  Future<void> _loadGames() async {
    try {
      final data = await GameService.fetchGames();
      if (!mounted) return;
      setState(() {
        _games = data;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _retry() {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    _loadGames();
  }

  
  Future<void> _openDetail(Game game) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailPage(game: game)),
    );
    
    if (!mounted) return;
    setState(() {});
  }


  void _toggleFav(Game game) {
    setState(() {
      game.isFav = !game.isFav;
    });
  }

  
  void _removeFromLibrary(Game game) {
    setState(() {
      game.inLibrary = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${game.title} dihapus dari library')),
    );
  }

  
  @override
  Widget build(BuildContext context) {
    const titles = ['GAMEVAULT', 'MY LIBRARY', 'FAVORITES'];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_currentIndex]),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Library'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
      ),
    );
  }

  Widget _buildBody() {

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_errorMessage != null) {
      return MessageView(
        icon: Icons.wifi_off,
        text: 'Gagal memuat data\n$_errorMessage',
        buttonText: 'Coba lagi',
        onPressed: _retry,
      );
    }

    
    return IndexedStack(
      index: _currentIndex,
      children: [
        HomeTab(
          games: _games,
          onTapGame: _openDetail,
          onToggleFav: _toggleFav,
        ),
        LibraryTab(
          games: _games,
          onTapGame: _openDetail,
          onRemove: _removeFromLibrary,
        ),
        FavoritesTab(
          games: _games,
          onTapGame: _openDetail,
          onToggleFav: _toggleFav,
        ),
      ],
    );
  }
}
