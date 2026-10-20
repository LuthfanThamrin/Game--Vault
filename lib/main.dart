import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool _fav1 = false;
  bool _fav2 = false;
  bool _fav3 = true;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      print(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF313338),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1F22),
        title: const Text('GameVault', style: TextStyle(color: Colors.white)),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1E1F22),
        selectedItemColor: const Color(0xFF5865F2),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_currentIndex == 1) {
      return const Center(
        child: Text('Halaman Library', style: TextStyle(color: Colors.white)),
      );
    }
    if (_currentIndex == 2) {
      return const Center(
        child: Text('Halaman Favorites', style: TextStyle(color: Colors.white)),
      );
    }
    return _buildHome();
  }

  Widget _buildHome() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          controller: _controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Search games...',
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            filled: true,
            fillColor: Color(0xFF1E1F22),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),

        const Text('MY LIBRARY', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),

        Row(
          children: [
            gameBox('Cyberpunk', Colors.purple),
            const SizedBox(width: 10),
            gameBox('Elden Ring', Colors.orange),
            const SizedBox(width: 10),
            gameBox('Red Dead 2', Colors.red),
          ],
        ),
        const SizedBox(height: 16),

        const Text('DISCOVER GAMES', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),

        gameRow('Grand Theft Auto V', 'Action • Open World', '4.5', _fav1, () {
          setState(() {
            _fav1 = !_fav1;
          });
        }),
        gameRow('Red Dead Redemption 2', 'Adventure', '4.9', _fav2, () {
          setState(() {
            _fav2 = !_fav2;
          });
        }),
        gameRow('Elden Ring', 'Souls-like • RPG', '4.8', _fav3, () {
          setState(() {
            _fav3 = !_fav3;
          });
        }),
      ],
    );
  }

  Widget gameBox(String title, Color color) {
    return Expanded(
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(8),
        child: Text(title, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget gameRow(
      String title, String genre, String rating, bool isFav, VoidCallback onFav) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF2B2D31),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                Text(genre, style: const TextStyle(color: Colors.grey)),
                Text('⭐ $rating', style: const TextStyle(color: Colors.amber)),
              ],
            ),
          ),
          IconButton(
            onPressed: onFav,
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}