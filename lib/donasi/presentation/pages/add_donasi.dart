import 'package:duitku/donasi/presentation/pages/donasi_page.dart';
import 'package:flutter/material.dart';
import 'package:duitku/donasi/data/messages/add_donasi_request.dart';
import 'package:duitku/donasi/presentation/bloc/providers/donasi_provider.dart';
import 'package:duitku/donasi/presentation/bloc/states/donasi_states.dart';

class AddDonasiPage extends StatefulWidget {
  static const routeName = "/donasi/add";

  const AddDonasiPage({super.key});

  @override
  State<AddDonasiPage> createState() => _AddDonasiPageState();
}

class _AddDonasiPageState extends State<AddDonasiPage> {
  final _addDonasiFormKey = GlobalKey<FormState>();

  DonasiProvider? _donasiProv;

  String? _name;
  double? _amount;
  String? _target;



  Future<void> _addDonasi() async {
    if (_addDonasiFormKey.currentState!.validate()) {
      final body = AddDonasiRequest(
        name: _name!,
        amount: _amount!,
        target: _target!,
  
      );

      await _donasiProv?.addDonasi(body: body);

      if (_donasiProv?.addDonasiState is AddDonasiOkState) {
        _donasiProv?.resetStates();

        if (mounted) {
          Navigator.of(context).pushReplacementNamed(DonasiHomePage.routeName);
        }
      } 
      else {
        final message =
            _donasiProv?.addDonasiState is AddDonasiFailureState
                ? (_donasiProv?.addDonasiState as AddDonasiFailureState)
                    .message
                : "an error occurred";

        final snackBar = SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 3),
        );

        if (mounted) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Donasi")),
      body: Form(
        key: _addDonasiFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Add New Donasi",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Name",
                                  hintText: "Input Your Name Here",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  contentPadding: const EdgeInsets.all(10),
                                ),
                                onChanged: (String? val) {
                                  setState(() {
                                    _name = val?.trim();
                                  });
                                },
                                onSaved: (String? val) {
                                  setState(() {
                                    _name = val?.trim();
                                  });
                                },
                                validator: (val) {
                                  if (val == null || val.trim().isEmpty) {
                                    return "Please enter your name for this Donasi";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 25),
                              TextFormField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  signed: false,
                                  decimal: true,
                                ),
                                decoration: InputDecoration(
                                  labelText: "Amount (Rp.)",
                                  hintText: "ex: 10000",
                                  contentPadding: const EdgeInsets.all(10),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                onChanged: (String? val) {
                                  setState(() {
                                    _amount =
                                        double.tryParse(val ?? "");
                                  });
                                },
                                onSaved: (String? val) {
                                  setState(() {
                                    _amount =
                                        double.tryParse(val ?? "");
                                  });
                                },
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Please enter the amount";
                                  } else if (double.tryParse(val) == null) {
                                    return "The amount must be numeric";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 25),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Target",
                                  hintText: "ex: Dompet Dhuafa",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  contentPadding: const EdgeInsets.all(10),
                                ),
                                onChanged: (String? val) {
                                  setState(() {
                                    _target = val?.trim();
                                  });
                                },
                                onSaved: (String? val) {
                                  setState(() {
                                    _target = val?.trim();
                                  });
                                },
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: _addDonasi,
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                      ),
                                      child: const Text(
                                        "Add",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}