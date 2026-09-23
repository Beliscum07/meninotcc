import 'package:flutter_riverpod/flutter_riverpod.dart';

// Este controller gerencia exclusivamente a regra de navegação do administrador
final adminNavController = StateProvider<int>((ref) => 0);