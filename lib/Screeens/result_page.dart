import 'package:covid_pass_scanner/Models/user_info.dart';
import 'package:covid_pass_scanner/Models/user_model.dart';
import 'package:flutter/material.dart';
import '../Constants/text_styles.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key, this.userModel, this.userInfo}) : super(key: key);

  final UserModel? userModel;
  final UserInfo? userInfo;

  String dateFormater(int value) {
    if (value < 10) {
      return "0$value";
    }
    return value.toString();
  }

  Widget suggestionText() {
    if(userInfo!.last_tested ==null){
      return Text("${userModel!.name.toUpperCase()} is not tested yet!!",
      style: const TextStyle(
        color: Colors.redAccent,
        fontSize: 27.0,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
      );
    }
    Duration difference =
        DateTime.now().difference(userInfo!.last_tested!.toDate());
    if (userInfo!.testresult?? false) {
      if (difference.inDays > 7) {
        return RichText(
          text: TextSpan(
            text:
                "It has alrealdy been more than 7 days since ${userModel!.name} took a covid test so ",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontStyle: FontStyle.italic,
            ),
            children: const [
              TextSpan(
                text: "DO NOT LET HIM IN THE OFFICE",
                style: TextStyle(
                  fontSize: 19.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        );
      }
    } else {
      if (difference.inDays < 14) {
        return Text(
          "${userModel!.name.toUpperCase()} HAS NOT RECOVERED YET SO HE MUST NOT BE ALLOWED TO ENTER INTO THE OFFICE",
          style: const TextStyle(
            fontSize: 19.0,
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        );
      } else {
        return RichText(
          text: TextSpan(
            text:
                "${userModel!.name.toUpperCase()} has finished his quarantine time but he didn't took a test again so. ",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontStyle: FontStyle.italic,
            ),
            children: const [
              TextSpan(
                text: "He must not be allowed in.",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        );
      }
    }
    return Container();
  }

  //

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(userModel!.name),
          centerTitle: false,
        ),
        body: userInfo!.last_tested ==null? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              margin: const EdgeInsets.all(20.0),
              child: Center(child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: suggestionText(),
              ),),
            ),
          ],
        ) :Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              margin: const EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0).copyWith(right: 30.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("name:", style: kGreyTextStyle),
                        Text(userModel!.name, style: kItalicOnly),
                      ],
                    ),
                    SizedBox(
                      height: size.height * .019,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("email:", style: kGreyTextStyle),
                        Text(userModel!.email, style: kItalicOnly),
                      ],
                    ),
                    SizedBox(
                      height: size.height * .019,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("last tested:", style: kGreyTextStyle),
                        Text(
                          dateFormater(userInfo!.last_tested!.toDate().day) +
                              "/" +
                              dateFormater(
                                  userInfo!.last_tested!.toDate().month) +
                              "/" +
                              userInfo!.last_tested!.toDate().year.toString(),
                          style: kItalicOnly,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * .019,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("last result:", style: kGreyTextStyle),
                        Text(
                          userInfo!.testresult?? false ? "Negative" : "Positive",
                          style: TextStyle(
                            color: userInfo!.testresult?? false
                                ? Colors.green
                                : Colors.red,
                            fontSize: 19.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * .026,
            ),
            userInfo!.testresult?? false
                ? DateTime.now().difference(userInfo!.last_tested!.toDate()).inDays < 7
                    ? Container()
                    : Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                "Suggestions",
                                style: kItalicOnly.copyWith(
                                  fontSize: 30.0,
                                ),
                              ),
                              SizedBox(
                                height: size.height * .026,
                              ),
                              suggestionText(),
                            ],
                          ),
                        ),
                      )
                : Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "Warniing!!!",
                            style: kItalicOnly.copyWith(
                              color: Colors.red,
                              fontSize: 30.0,
                            ),
                          ),
                          SizedBox(
                            height: size.height * .026,
                          ),
                          suggestionText(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: size.height*.25,)
          ],
        ),
      ),
    );
  }
}
