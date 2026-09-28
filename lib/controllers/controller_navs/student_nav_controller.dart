import 'package:flutter_riverpod/flutter_riverpod.dart';

// Este controller gerencia exclusivamente a regra de navegação do estudante
final studentNavController = StateProvider<int>((ref) => 0);
