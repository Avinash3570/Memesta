import 'dart:convert';
import 'package:http/http.dart';

class FetchMeme {
  static fetchNewMeme() async {
    Response response = await get(Uri.parse("https://www.reddit.com/r/memes/random/.json"));

    // Decode the response body
    List bodyData = jsonDecode(response.body);

    // Access the first object in the list and extract the URL
    var memeData = bodyData[0]["data"]["children"][0]["data"];

    return memeData["url"];  // This returns the meme image URL
  }
}
