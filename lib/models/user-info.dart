class UserInfo{
   String id;
   String name;
   String password;
   int phone;
   String email;
   DateTime birthDate;
   bool female;
   String facebook;
   String google;

  UserInfo({this.id, this.name, this.password, this.phone, this.email, this.birthDate, this.female, this.facebook, this.google});
  userToMap(){
    return {
      "name":name,
      "password":password,
      "phone":phone,
      "email":email,
      "birthDate":birthDate,
      "female":female,
      "facebook":facebook,
      "google":google,
    };
  }
}
UserInfo mapToUserInfo(Map info) {
  return UserInfo(
    phone: info["phone"],
    facebook: info["facebook"],
    name: info["name"],
    birthDate: info["birthDate"]?.toDate(),
    email: info["email"],
    password: info["password"],
    id: info["id"],
    female: info["female"],
    google: info["google"],
  );
}