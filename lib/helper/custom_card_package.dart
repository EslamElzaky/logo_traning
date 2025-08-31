import 'package:flutter/material.dart';

class PackageItem extends StatefulWidget {
  final String title;
  final String oldPrice;
  final String newPrice;

  const PackageItem({
    super.key,
    required this.title,
    required this.oldPrice,
    required this.newPrice,
  });

  @override
  State<PackageItem> createState() => _PackageItemState();
}

class _PackageItemState extends State<PackageItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.grey),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            widget.oldPrice,
                            style: const TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.red,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.newPrice,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Icon(
                        isExpanded ? Icons.remove : Icons.add,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: double.infinity,
            height: isExpanded ? 220 : 0,
            padding: isExpanded ? const EdgeInsets.all(12) : EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: isExpanded
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "سعر الباقة : 12,800.00 ريال",
                          style: TextStyle(color: Colors.black),
                        ), // ✅ أسود
                        Text(
                          "عدد العاملات : 1 عاملة",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          "عدد الساعات : 4 ساعات للزيارة",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          "عدد الزيارات : 1 زيارة",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          "السعر بعد الخصم : 3570.99 ريال",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          "نسبة الضريبة : 15%",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          "قيمة الضريبة للسعر النهائي : 472.17 ريال",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          "السعر النهائي : 3620.00 ريال",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          "السعر شامل الضريبة و الخصم",
                          style: TextStyle(color: Colors.teal),
                        ),
                      ],
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
