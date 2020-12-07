import 'dart:convert';

DeliveryBoy deliveryBoyFromJson(String str) => DeliveryBoy.fromJson(json.decode(str));

String deliveryBoyToJson(DeliveryBoy data) => json.encode(data.toJson());

class DeliveryBoy {
    DeliveryBoy({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.latitude,
        this.longitude,
        this.deviceToken,
        this.password,
        this.assigned,
        this.monthly,
        this.blocked,
        this.monthlyreset,
        this.completed,
        this.createdAt,
        this.updatedAt,
    });

    String id;
    String name;
    bool blocked;
    bool monthlyreset;
    String email;
    String monthly;
    String phone;
    String latitude;
    String longitude;
    String deviceToken;
    String password;
    String assigned;
    String completed;
    String createdAt;
    String updatedAt;

    factory DeliveryBoy.fromJson(Map<String, dynamic> json) => DeliveryBoy(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        latitude: json["latitude"] == null ? "0.0" : json["latitude"],
        longitude: json["longitude"] == null ? "0.0" : json["longitude"],
        deviceToken: json["deviceToken"] == null ? null : json["deviceToken"],
        password: json["password"] == null ? null : json["password"],
        assigned: json["assigned"] == null ? "0" : json["assigned"],
        monthly: json["monthly"] == null ? "0": json["monthly"],
        monthlyreset: json["monthlyreset"] == null ? false : json["monthlyreset"],
        blocked: json["blocked"] == null ? false : json["blocked"],
        completed: json["completed"] == null ? "0" : json["completed"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "monthlyreset": monthlyreset == null ? false: monthlyreset,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "monthly": monthly == null ? "0.0": monthly,
        "latitude": latitude == null ? "0.0" : latitude,
        "longitude": longitude == null ? "0.0" : longitude,
        "deviceToken": deviceToken == null ? null : deviceToken,
        "password": password == null ? null : password,
        "assigned": assigned == null ? "0" : assigned,
        "completed": completed == null ? "0" : completed,
        "blocked": blocked == null ? false : blocked,
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
    };
}
