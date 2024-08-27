import 'package:flutter/material.dart';
import 'package:moves_app_project/ui/movies_pages/watch_list/watch_list_screen/watch_list_screen.dart';

import '../movies_pages/browse/browse_screen.dart';
import '../movies_pages/movies/movies_home_screen/movies_screen.dart';
import '../movies_pages/search/search_screen.dart';
import '../utils/color_resource/color_resources.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = "Home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<Widget> getTabs() {
    return [
      MoviesScreen(),
      const SearchScreen(),
      const BrowseScreen(),
      WatchlistScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: ColorResources.navBar),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: "Browse",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.view_list_outlined),
              label: "Watchlist",
            ),
          ],
        ),
      ),
      body: getTabs()[selectedIndex],
    );
  }
}
