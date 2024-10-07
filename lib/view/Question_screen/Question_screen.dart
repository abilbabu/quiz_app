import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/dummy_db.dart';
import 'package:quiz_app/utils/animations_constants.dart';
import 'package:quiz_app/utils/color_constants.dart';
import 'package:quiz_app/view/ResultScreen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  dynamic count = 0;
  int? selectedanswerindex;
  int rightAnswerCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primarycolor,
        actions: [
          Text(
            "${count + 1} / ${DummyDb.questionList.length}",
            style: TextStyle(color: ColorConstants.White),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        DummyDb.questionList[count]["question"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: ColorConstants.White),
                      ),
                    ),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: ColorConstants.Gold, width: 5),
                        color: ColorConstants.primarycolor,
                        borderRadius: BorderRadius.circular(15)),
                  ),

                  // lottie animation
                  if (selectedanswerindex ==
                      DummyDb.questionList[count]["answerindex"])
                    Lottie.asset(AnimationsConstants.RightAnsAnimation,
                        width: 1000, height: 1000)
                  else if (selectedanswerindex != null)
                    if (selectedanswerindex !=
                        DummyDb.questionList[count]["answerindex"])
                      Center(
                        child: Lottie.asset(
                            AnimationsConstants.WrongAnsAnimation,
                            width: 450,
                            height: 300),
                      ),
                ],
              ),
            ),
            Column(
                children: List.generate(
              DummyDb.questionList[count]["options"].length,
              (index) => Padding(
                padding: const EdgeInsets.only(top: 20),
                child: InkWell(
                  onTap: () {
                    if (selectedanswerindex == null) {
                      setState(() {
                        selectedanswerindex = index;

                        if (index ==
                            DummyDb.questionList[count]["answerindex"]) {
                          rightAnswerCount++;
                        }
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: getcolor(index), width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DummyDb.questionList[count]["options"][index],
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: ColorConstants.White),
                        ),
                        Icon(
                          Icons.circle_outlined,
                          color: ColorConstants.Gold,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
            SizedBox(
              height: 20,
            ),
            if (selectedanswerindex != null)
              InkWell(
                onTap: () {
                  setState(() {});

                  selectedanswerindex = null;
                  if (count < DummyDb.questionList.length - 1) {
                    count++;
                  } else {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(
                            RightansCount: rightAnswerCount,
                          ),
                        ));
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorConstants.Gold),
                  child: Center(
                    child: Text(
                      "Next",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: ColorConstants.White),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Color getcolor(int optionIndex) {
    if (selectedanswerindex != null &&
        optionIndex == DummyDb.questionList[count]["answerindex"]) {
      return ColorConstants.Green;
    }

    if (selectedanswerindex == optionIndex) {
      if (selectedanswerindex == DummyDb.questionList[count]["answerindex"]) {
        return ColorConstants.Green;
      } else {
        return ColorConstants.red;
      }
    } else {
      return ColorConstants.Gold;
    }
  }
}
