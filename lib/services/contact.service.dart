import '../model/contact.model.dart';
import '../utils/contact.database.dart';

class ContactService {
  Future<List<Contact>> listeContacts() async {
    List<Map<String, dynamic>> contacts = await ContactDatabase.recuperer();
    return contacts.map((item) => Contact.fromJson(item)).toList();
  }
//Méthode d’ajoutcontact du service permettant d’inserrer un contact
  Future<bool> ajouterContact(Contact c) async {
    int res = await ContactDatabase.inserer(c);
    return res > 0 ? true : false;
  }
//Méthode modifierContact du service permettant de modifier un contact
  Future<bool> modifierContact(Contact c) async {
    int res = await ContactDatabase.modifier(c);
    return res > 0 ? true : false;
  }
//Méthode supprimerContact du service permettant de supprimer un contact
  Future<bool> supprimerContact(Contact c) async {
    int res = await ContactDatabase.supprimer(c);
    return res > 0 ? true : false;
  }
}

