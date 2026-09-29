import 'package:flutter_riverpod/flutter_riverpod.dart';

// Este controller gerencia exclusivamente a regra de navegação do doador
final doadorNavController = StateProvider<int>((ref) => 0);