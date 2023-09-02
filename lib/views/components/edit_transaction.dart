import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditTransaction extends StatelessWidget {
  const EditTransaction({super.key});

  @override
  Widget build(BuildContext context) {

    dynamic transactionModal = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Transaction"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                initialValue: transactionModal.category,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                initialValue: transactionModal.remarks,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                initialValue: transactionModal.amount.toString(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              CupertinoSlidingSegmentedControl(
                groupValue: transactionModal.type,
                children: const {
                  'INCOME': Text("INCOME"),
                  'EXPANSE': Text("EXPANSE"),
                },
                onValueChanged: (val) {
                  transactionModal.type = val!;
                },
              ),
              Row(
                children: [
                  TextFormField(
                    initialValue: transactionModal.date,
                  ),
                  TextFormField(
                    initialValue: transactionModal.time,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
