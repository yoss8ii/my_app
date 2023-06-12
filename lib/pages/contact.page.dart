
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/list_helper.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../model/contact.model.dart';
import '../services/contact.service.dart';
import 'ajout_modif_contact.page.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  ContactService dbService = ContactService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("CRUD Contact"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child:FormHelper.submitButton(
                  "Ajout",
                      () {
                    Navigator.pop(context);//fermer le fichier courant
                    Navigator.pushNamed(context, '/addeditcontact');
                  },
                  borderRadius: 10,
                  btnColor: Colors.lightBlue,
                  borderColor: Colors.lightBlue,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _fetchData(),
            ],
          ),
        ));
  }

  _fetchData() {
    return FutureBuilder<List<Contact>>(

      future: dbService.listeContacts(),

      builder:
          (BuildContext context, AsyncSnapshot<List<Contact>> contacts) {
        if (contacts.hasData) {

          return _buildDataTable(contacts.data!);

          //return _buildDataTable(contacts.data!);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  _buildDataTable(List<Contact> model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListUtils.buildDataTable(
        context,
        ["Nom", "Telephone", ""],
        ["nom", "tel", ""],
        false,
        0,
        model,
            (Contact data) {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context)=>AjoutModifContact(
                isEditMode: true,
                model:data,
              ),
            ),
          );

        },
            (Contact data) {
          return
            showDialog(context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  title: const Text("CRUD Contact"),
                  content: const Text("Etes vous sur d\'avoir supprimer ce contact?"),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FormHelper.submitButton("Oui", (){
                          dbService.supprimerContact(data).then((value){
                            setState(() {
                              Navigator.of(context).pop();
                            });
                          }
                          );
                        },
                          width: 100,
                          borderRadius: 5,
                          btnColor: Colors.green,
                          borderColor: Colors.green,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        FormHelper.submitButton("Non", (){
                          Navigator.of(context).pop();
                        },
                          width: 100,
                          borderRadius: 5,
                        ),
                      ],
                    )
                  ],
                );
              },
            );
        },
        headingRowColor: Colors.orangeAccent,
        isScrollable: true,
        columnTextFontSize: 15,
        columnTextBold: false,
        columnSpacing: 50,
        onSort: (columnIndex, columnName, asc) {},
      ),
    );
  }
}
