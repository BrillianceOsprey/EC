import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Order with ChangeNotifier {
  final String orderId;
  final String userId;
  final String productId;
  final String title;
  final String price;
  final String imageUrl;
  final String quantity;
  final Timestamp orderDate;

  Order({
    required this.orderId,
    required this.userId,
    required this.productId,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.orderDate,
    required this.quantity,
  });
}