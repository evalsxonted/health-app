class OfferInfo{
   String id;
   String offerName;
   String providerDoctor;
   String providerCenter;
   String providerPharma;
   int oldPrice;
   int newPrice;
   int discountPercent;
   String image;
   String description;
   String offerTime;
   String location;
   int visitors;
   double rating;
   String profession;
  OfferInfo({this.id, this.offerName, this.providerDoctor, this.providerCenter, this.providerPharma, this.oldPrice,
      this.newPrice, this.discountPercent, this.image, this.description, this.offerTime, this.location, this.visitors, this.rating, this.profession});
   Map<String, dynamic> offerToMap(){
      return {
         "rating" : rating,
         "image" : image,
         "description" : description,
         "location" : location,
         "visitors" : visitors,
         "offerName" : offerName,
         "providerDoctor" : providerDoctor,
         "providerCenter" : providerCenter,
         "providerPharma" : providerPharma,
         "oldPrice" : oldPrice,
         "newPrice" : newPrice,
         "discountPercent" : discountPercent,
         "offerTime" : offerTime,
         "profession" : profession,
      };
   }
}
OfferInfo mapToOffer(Map info){
   return OfferInfo(
      id: info["id"],
      rating: info["rating"] / info["visitors"],
      image: info["image"],
      description: info["description"],
      location: info["location"],
      visitors: info["visitors"],
      providerCenter: info["providerCenter"],
      offerTime: info["offerTime"],
      offerName: info["offerName"],
      oldPrice: info["oldPrice"],
      newPrice: info["newPrice"],
      discountPercent: info["discountPercent"],
      providerDoctor: info["providerDoctor"],
      providerPharma: info["providerPharma"],
      profession: info["profession"],
   );
}