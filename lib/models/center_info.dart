
class CenterInfo{
   String id;
   String name;
   String location;
   String profession;
   double rating;
   int visitors;
   String description;
   int phone;
   String workTime;
   String about;
   List<String> doctorsId;
   String image;
   String map;
  CenterInfo({this.id, this.name, this.location, this.profession, this.rating, this.visitors,
  this.description, this.phone, this.workTime, this.about, this.doctorsId, this.image, this.map});

   Map<String, dynamic> centerToMap(){
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
       "profession": profession,
       "about": about
     };
   }
}

CenterInfo mapToCenter(Map info){
  return CenterInfo(
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
    about: info["about"],
    profession: info["profession"],
  );
}