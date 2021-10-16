
class PharmaInfo{
   String id;
   String name;
   double rating;
   int visitors;
   String location;
   int phone;
   String  workTime;
   String description;
   List<String> doctorsId;
   String image;
   String map;

  PharmaInfo({this.id, this.name, this.rating, this.visitors, this.location, this.phone, this.workTime, this.description, this.doctorsId, this.image, this.map});

   Map<String, dynamic> pharmaToMap(){
      return {
         "name" : name,
         "rating" : rating,
         "image" : image,
         "phone" : phone,
         "map" : map,
         "workTime" : workTime,
         "description" : description,
         "location" : location,
         "visitors" : visitors,
         "doctorsId" : doctorsId,
      };
   }
}
PharmaInfo mapToPharma(Map info){
   return PharmaInfo(
      id: info["id"],
      rating: info["rating"] / info["visitors"],
      image: info["image"],
      phone: info["phone"],
      name: info["name"],
      map: info["map"],
      workTime: info["workTime"],
      description: info["description"],
      location: info["location"],
      visitors: info["visitors"],
      doctorsId: info["doctorsId"].cast<String>(),
   );
}