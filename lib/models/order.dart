class Order{
  String image;
  String productName;
  double productPrice;
  String size;
  String deliveryCode;
  String payment;
  String progress;
  String customerName;
  double rate;
  bool isVisible;

  Order(this.image,this.productName,this.productPrice,this.size,this.deliveryCode,this.payment,this.progress,this.customerName,this.rate,this.isVisible);

}
List<Order> orders=[Order('assets/images/profile_img.jpg','Berbera',23.00,'some','AXXACS','verified','delivery in progress','Hanan',4.50,false),
Order('assets/images/profile_img.jpg','Berbera',100.00,'some','AXXACS','verified','delivery in progress','Hanan',2.50,false),
Order('assets/images/profile_img.jpg','Berbera',23.00,'some','AXXACS','verified','delivery in progress','Hanan',4.50,false)];