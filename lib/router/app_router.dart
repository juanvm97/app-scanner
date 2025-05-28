import 'package:app_scanner/screens/add_item_screen.dart';
import 'package:app_scanner/screens/barcode_scanner_screen.dart';
import 'package:app_scanner/screens/home_screen.dart';
import 'package:app_scanner/screens/list_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/list/:id',
      name: 'list',
      builder: (context, state) {
        final listId = state.pathParameters['id']!;
        return ListScreen(listId: listId);
      },
    ),
    GoRoute(
      path: '/scanner',
      builder: (context, state) => const BarcodeScannerScreen(),
    ),
    GoRoute(
      path: '/add-item',
      builder: (context, state) => const AddItemScreen(),
    ),
  ],
);
