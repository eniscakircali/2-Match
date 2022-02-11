import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//users attributes:
//id, name, password, nickname, type, requests, matches,

class Functions {
  Dio dio = Dio();
  // takes two parameters and connecting to our server. Function checking database with these two parameters and returning message.
  login(name, password) async {
    try {
      return await dio.post('http://localhost:3000/authenticator',
          data: {"name": name, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response!.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red[800],
          textColor: Colors.white,
          fontSize: 16);
    }
  }

// takes three parameters and connecting to our server. Function adding new users to our database with checking users that already registered.
  addUser(name, password, nickname) async {
    try {
      return await dio.post("http://localhost:3000/adduser",
          data: {"name": name, "password": password, "nickname": nickname},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response!.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red[800],
          textColor: Colors.white,
          fontSize: 16);
    }
  }

// this function checking for user has a type or not.
  flagCheck(name) async {
    try {
      return await dio.post("http://localhost:3000/flagcheck",
          data: {"name": name},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {}
  }

// this function updating user type by survey result.
  updateType(name, type) async {
    try {
      return await dio.post("http://localhost:3000/updatetype",
          data: {"name": name, "type": type},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {}
  }

// this function returning user type.
  getType(name) async {
    try {
      return await dio.post("http://localhost:3000/getType",
          data: {"name": name},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {}
  }

// this function geting all users by given type.
  findMatch(type) async {
    try {
      return await dio.post("http://localhost:3000/findMatch",
          data: {"type": type},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {}
  }

// this function sending a request to user from another user. Name variable geting request and value variable is the sender.
  sendRequest(name, value) async {
    try {
      return await dio.post("http://localhost:3000/sendRequest",
          data: {"name": name, "value": value},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {}
  }

// this function geting users requests and matches.
  getRequests(name) async {
    try {
      return await dio.post("http://localhost:3000/getRequests",
          data: {"name": name},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {}
  }

// once this function called it's deleting value from requests and adding to matches.
  acceptRequest(name, value) async {
    try {
      return await dio.post("http://localhost:3000/acceptRequest",
          data: {"name": name, "value": value},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {}
  }

// once this function called it's deleting value from requests.
  declineRequest(name, value) async {
    try {
      return await dio.post("http://localhost:3000/declineRequest",
          data: {"name": name, "value": value},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {}
  }

// this function returning users name and type.
  returnUser(name) async {
    try {
      return await dio.post("http://localhost:3000/returnUser",
          data: {"name": name},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {}
  }

// this function returning users name, type and nickname.
  returnUserWithNickname(name) async {
    try {
      return await dio.post("http://localhost:3000/returnUserWithNickname",
          data: {"name": name},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {}
  }
}
