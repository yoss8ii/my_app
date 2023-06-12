class Contact {
   static String table = "contact";
// Les attributs de la classe Contact
   String? id;
   String? nom;
   String? tel;

//Constructeur nommée{} appel id:
   Contact({this.id, required this.nom, required this.tel});
// convertit un objet Map en un contact ta9ra min map(return contact model
   static Contact fromJson(Map<String, dynamic> json) {
      return Contact(
          id: json["id"].toString(), nom: json['nom'].toString(), tel: json['tel'].toString());
   }
// convertit un contact en un objet Map(return Map from contact
   Map<String, dynamic> toJson() {
         Map<String,dynamic>map={
            'id': id,
            'nom': nom,
            'tel': tel,
         };
         //car l'id c'est un key primaire n'est pas null
         if(id!=null){
            map['id']=id;
         }
      return map;

   }
}
