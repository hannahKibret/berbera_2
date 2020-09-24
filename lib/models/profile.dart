class Profile{
  String image;
  String fullName;
  String contact;

  //Store store;
 // Bank bank;

  Profile({this.image,this.fullName,this.contact});
}

class Store{
  String storeName;
  String storeLocation;
  String category;
  String workingHours;

  Store({this.storeName,this.storeLocation,this.category,this.workingHours});
}

class Bank{
  String customer;
  String bankName;
  String bankAccount;

  Bank({this.bankName,this.bankAccount});
}

enum StoreLocation{
  Bole,Megenagna
}

//enum Categories{
//  Male,Female
//}

//enum BankName{
//  CBE,Awash
//}
List<String> StoreLocations = ["Bole","Megenagna",'Piassa','4 Kilo','22','CMC','Ayat'];
List<String> Categories = ["Male","Female","Kids","All"];
List<String> BankName = ["CBE","Awash",'Enat','Nib'];