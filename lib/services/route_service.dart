import '../screens/home_page.dart';
import '../screens/alarm_ring.dart';

class RouteService {
  final route = {
    "/": (context) => const HomeScreen(),
    "/alarm_ring": (context) => const AlarmRingScreen(),
  };
}
