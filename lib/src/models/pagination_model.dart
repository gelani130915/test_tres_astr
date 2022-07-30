// To parse this JSON data, do
//
//     final pagination = paginationFromJson(jsonString);

import 'dart:convert';

Pagination paginationFromJson(String str) => Pagination.fromJson(json.decode(str));

String paginationToJson(Pagination data) => json.encode(data.toJson());

class Pagination {
    int totalCount;
    int count;
    int offset;
    Pagination({
        required this.totalCount,
        required this.count,
        required this.offset,
    });



    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalCount: json["total_count"],
        count: json["count"],
        offset: json["offset"],
    );

    Map<String, dynamic> toJson() => {
        "total_count": totalCount,
        "count": count,
        "offset": offset,
    };
}