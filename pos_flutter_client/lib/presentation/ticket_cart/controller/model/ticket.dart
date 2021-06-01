import 'package:pos_flutter_client/presentation/order/controller/models/item.dart';

class Ticket {
  final Item item;
  final int amount;

  Ticket({required this.item, required this.amount});
}
