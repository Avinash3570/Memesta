import 'package:demo/view/controller/saveMyData.dart';
import 'package:flutter/material.dart';
import 'package:demo/view/controller/fetchMeme.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String imgUrl = "";  // Default image
  int? memeNo = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    GetInitMemeNo();
    UpdateImg();
  }

  GetInitMemeNo() async {
    memeNo = await SaveMyData.fetchData() ?? 0;
    setState(() {});
  }

  void UpdateImg() async {
    setState(() {
      isLoading = true;  // Start loading
    });

    // Fetch new image URL
    String getImgUrl = await FetchMeme.fetchNewMeme();

    // Update the state with the new image URL and stop loading
    setState(() {
      imgUrl = getImgUrl;
      isLoading = false;  // Stop loading after the image is fetched
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Text("Meme #$memeNo", style: const TextStyle(fontSize: 54)),
            const Text("Target 500 memes", style: TextStyle(fontSize: 34)),
            const SizedBox(height: 20),

            // Show CircularProgressIndicator while loading
            isLoading
                ? SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(),
                ),
              ),
            )
                : Image.network(
              imgUrl.isNotEmpty
                  ? imgUrl
                  : "https://example.com/fallback_image.jpg",  // Fallback image
              height: 300,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitHeight,
            ),

            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                if (memeNo != null) {
                  await SaveMyData.saveData(memeNo! + 1);
                } else {
                  await SaveMyData.saveData(1);  // Or any default value to start with
                }

                GetInitMemeNo();
                UpdateImg();  // Fetch new image when pressed
              },
              child: const SizedBox(
                height: 70,
                width: 90,
                child: Center(
                  child: Text(
                    "More Fun",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            const Spacer(),
            const Text(
              "App created by",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const Text(
              "Avinash",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
