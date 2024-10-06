import 'package:flutter/material.dart';
import 'package:quiz_app/dummy_db.dart';
import 'package:quiz_app/utils/color_constants.dart';
import 'package:quiz_app/view/Question_screen/Question_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.RightansCount});
  final int RightansCount;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int starCount = 0;
  calculatePercentage() {
    var percentage = (widget.RightansCount / DummyDb.questionList.length) * 100;
    if (percentage >= 80) {
      starCount = 3;
    } else if (percentage >= 50) {
      starCount = 2;
    } else if (percentage >= 30) {
      starCount = 1;
    } else {
      starCount = 0;
    }
  }

  @override
  void initState() {
    calculatePercentage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                3,
                (index) => Padding(
                  padding: EdgeInsets.only(
                      left: 15, right: 15, bottom: index == 1 ? 30 : 0),
                  child: Icon(
                    Icons.star,
                    color: index < starCount
                        ? ColorConstants.Gold
                        : ColorConstants.secondarycolor,
                    size: index == 1 ? 80 : 50,
                  ),
                ),
              )),
          SizedBox(
            height: 10,
          ),
          Text(
            "Congratulations",
            style: TextStyle(
                fontSize: 25,
                color: ColorConstants.Gold,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 25),
          Text("Your score",
              style: TextStyle(
                color: ColorConstants.White,
              )),
          SizedBox(
            height: 10,
          ),
          Text(
            "${widget.RightansCount} / ${DummyDb.questionList.length}",
            style: TextStyle(
                color: ColorConstants.Gold,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.circular(15)),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 15,
                  child: Icon(
                    Icons.replay,
                    color: ColorConstants.White,
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionScreen(),
                        ));
                  },
                  child: Text(
                    "Retry",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                )
              ],
            )),
          )
        ],
      ),
    );
  }
}
