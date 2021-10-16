class DoctorInfo{
   String id;
   String name;
   String profession;
   int ticketPrice;
   double rating;
   String image;
   int visitors;
   String description;
   String location;
   int phone;
   String workTime;
   String about;
   String map;

  DoctorInfo({this.id, this.description, this.location, this.phone, this.workTime, this.about, this.name,
    this.profession, this.ticketPrice, this.rating, this.image, this.visitors, this.map});
  Map<String, dynamic> doctorToMap(){
    return {
      "name" : name,
      "rating" : rating,
      "image" : image,
      "phone" : phone,
      "map" : map,
      "profession" : profession,
      "about" : about,
      "workTime" : workTime,
      "description" : description,
      "location" : location,
      "visitors" : visitors,
      "ticketPrice" : ticketPrice,

    };
  }
}
DoctorInfo mapToDoctor(Map info){
  return DoctorInfo(
    id: info["id"],
    rating: info["rating"] / info["visitors"],
    image: info["image"],
    phone: info["phone"],
    name: info["name"],
    map: info["map"],
    profession: info["profession"],
    about: info["about"],
    workTime: info["workTime"],
    description: info["description"],
    location: info["location"],
    visitors: info["visitors"],
    ticketPrice: info["ticketPrice"],
  );
}