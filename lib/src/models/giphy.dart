// To parse this JSON data, do
//
//     final giphy = giphyFromJson(jsonString);

import 'dart:convert';

Giphy giphyFromJson(String str) => Giphy.fromJson(json.decode(str));

String giphyToJson(Giphy data) => json.encode(data.toJson());

class Giphy {
    Giphy({
        this.type,
        this.id,
        this.url,
        this.username,
        this.source,
        this.title,
        this.rating, 
        this.images,
    });

    String? type;
    String? id;
    String? url;
    String? username;
    String? source;
    String? title;
    String? rating; 
    Images? images;

    factory Giphy.fromJson(Map<String, dynamic> json) => Giphy(
        type: json["type"],
        id: json["id"],
        url: json["url"],
        username: json["username"],
        source: json["source"],
        title: json["title"],
        rating: json["rating"],  
        images: Images.fromJson(json["images"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "url": url,
        "username": username,
        "source": source,
        "title": title,
        "rating": rating,  
        "images": images!.toJson(),
    };
}

class Images {
    Images({
        this.looping,
    });

    Looping? looping;

    factory Images.fromJson(Map<String, dynamic> json) => Images(
        looping: Looping.fromJson(json["looping"]),
    );

    Map<String, dynamic> toJson() => {
        "looping": looping!.toJson(),
    };
}

class Looping {
    Looping({
        this.mp4Size,
        this.mp4,
    });

    String? mp4Size;
    String? mp4;

    factory Looping.fromJson(Map<String, dynamic> json) => Looping(
        mp4Size: json["mp4_size"],
        mp4: json["mp4"],
    );

    Map<String, dynamic> toJson() => {
        "mp4_size": mp4Size,
        "mp4": mp4,
    };
}