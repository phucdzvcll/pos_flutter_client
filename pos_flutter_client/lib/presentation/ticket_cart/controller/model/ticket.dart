import 'package:pos_flutter_client/presentation/order/controller/models/item.dart';

class Ticket {
  final Item item;
  final int amount;
  final String? comment;

  double totalPrice() {
    return this.amount * this.item.price;
  }

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Ticket({
    required this.item,
    required this.amount,
    this.comment,
  });

  Ticket copyWith({
    Item? item,
    int? amount,
    String? comment,
  }) {
    if ((item == null || identical(item, this.item)) &&
        (amount == null || identical(amount, this.amount)) &&
        (comment == null || identical(comment, this.comment))) {
      return this;
    }

    return new Ticket(
      item: item ?? this.item,
      amount: amount ?? this.amount,
      comment: comment ?? this.comment,
    );
  }

  @override
  String toString() {
    return 'Ticket{item: $item, amount: $amount, comment: $comment}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ticket &&
          runtimeType == other.runtimeType &&
          item == other.item &&
          amount == other.amount &&
          comment == other.comment);

  @override
  int get hashCode => item.hashCode ^ amount.hashCode ^ comment.hashCode;

//</editor-fold>
}
