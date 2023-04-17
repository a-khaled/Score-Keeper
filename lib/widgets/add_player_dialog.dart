import 'package:flutter/material.dart';

class AddPlayerDialog {
  static final formKey = GlobalKey<FormState>();
  static String newPLayerName = "";

  static dialog(BuildContext context, Function function) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text("Enter Player Name"),
              content: Form(
                key: formKey,
                child: TextFormField(
                  maxLength: 18,
                  onChanged: (val) {
                    setState(() {
                      newPLayerName = val;
                    });
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "player name can't be empty";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(20)),
                    errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    newPLayerName = "";
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      function();
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  child: const Text("Add"),
                ),
              ],
            );
          });
        });
  }
}
