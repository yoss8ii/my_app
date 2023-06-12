import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../model/contact.model.dart';
import '../services/contact.service.dart';

class AjoutModifContact extends StatefulWidget {
  const AjoutModifContact({Key? key, this.model, this.isEditMode = false})
      : super(key: key);
  final Contact? model;
  final bool isEditMode;


  @override
  State<AjoutModifContact> createState() => _AddEditContactPageState();
}

class _AddEditContactPageState extends State<AjoutModifContact> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late Contact model;
  late ContactService dbService;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(widget.isEditMode ? 'Edit Contact' : 'Add Contact'),
      ),
      body: Form(
        key: globalKey,
        child: _formUI(),
      ),
      bottomNavigationBar: SizedBox(
        height: 110,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FormHelper.submitButton(
              "Enregistrer",
                  () {
                if (validateAndSave()) {
                  print(model.toJson());
                  if (widget.isEditMode) {
                    dbService.modifierContact(model).then(
                          (value) {
                        // FormHelper.showSimpleAlertDialog(
                        //   context,
                        //   "CRUD Voyage ",
                        //   "Données modifiées avec succès",
                        //   "Ok",
                        //   () {
                        //     Navigator.pop(context);
                        //   },
                        // );
                      },
                    );
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/contact');
                  } else {
                    dbService.ajouterContact(model).then(
                          (value) {
                        // FormHelper.showSimpleAlertDialog(
                        //   context,
                        //   "CRUD Contact ",
                        //   "Ajout effectué avec succès",
                        //   "Ok",
                        //       () {
                        //     Navigator.pop(context);
                        //   },
                        // );
                      },
                    );
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/contact');
                  }
                }

              },
              borderRadius: 10,
              btnColor: Colors.green,
              borderColor: Colors.green,
            ),
            FormHelper.submitButton(
              "Cancel",
                  () {
                Navigator.pop(context);
              },
              borderRadius: 10,
              btnColor: Colors.grey,
              borderColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    dbService = ContactService();
    model = Contact(nom: "", tel: "");
    if (widget.isEditMode) {
      model = widget.model!;
    }
  }

  _formUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "Nom",
              "Name",
              "",
                  (onValidate) {
                if (onValidate.isEmpty) {
                  return "* Required";
                }
                return null;
              },
                  (onSaved) {
                model.nom = onSaved.toString().trim();
              },
              initialValue: model.nom.toString(),
              showPrefixIcon: true,
              prefixIcon: const Icon(Icons.text_fields),
              borderRadius: 10,
              contentPadding: 15,
              fontSize: 14,
              labelFontSize: 14,
              paddingLeft: 0,
              paddingRight: 0,
              prefixIconPaddingLeft: 10,
            ),
            FormHelper.inputFieldWidgetWithLabel(context, "tel", "Phone", "",
                    (onValidate) {
                  if (onValidate.isEmpty) {
                    return "* Required";
                  }
                  return null;
                }, (onSaved) {
                  model.tel = onSaved.toString().trim();
                },
                initialValue: model.tel.toString(),
                showPrefixIcon: true,
                prefixIcon: const Icon(Icons.text_fields),
                borderRadius: 10,
                contentPadding: 15,
                fontSize: 14,
                labelFontSize: 14,
                paddingLeft: 0,
                paddingRight: 0,
                prefixIconPaddingLeft: 10,
                isNumeric: true),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
