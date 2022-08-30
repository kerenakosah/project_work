import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:projectwork/index.dart';

class PatientPage extends StatefulWidget {
  // page id
  static const id = BrandStrings.patientPage;
  const PatientPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Stack(
                  children: <Widget>[
                    const OpaqueImage(
                      imageUrl: Assets.imagesAnne,
                    ),
                    SafeArea(
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                BrandStrings.patientProfile,
                                textAlign: TextAlign.center,
                                style: BrandStyles.headingTextStyle,
                              ),
                            ),
                            const MyInfo(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// cards
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(top: 70.0),
                    margin: const EdgeInsets.only(bottom: 20.0),
                    color: Colors.white,
                    child: Table(
                      children: [
                        // first row
                        TableRow(
                          children: [
                            // new events
                            ProfileInfoBigCard(
                              firstText: "13",
                              secondText: BrandStrings.newEvents,
                              icon: Icon(
                                Icons.star,
                                size: 32.0,
                                color: BrandColors.blueColor,
                              ),
                            ),

                            // responded events
                            ProfileInfoBigCard(
                              firstText: "21",
                              secondText: BrandStrings.respondedEvents,
                              icon: Image.asset(
                                Assets.iconsSadSmiley,
                                width: 32,
                                color: BrandColors.blueColor,
                              ),
                            ),
                          ],
                        ),

                        /// second row
                        TableRow(
                          children: [
                            // all events
                            ProfileInfoBigCard(
                              firstText: "264",
                              secondText: BrandStrings.allEvents,
                              icon: Image.asset(
                                Assets.iconsChecklist,
                                width: 32,
                                color: BrandColors.blueColor,
                              ),
                            ),

                            /// rematch
                            ProfileInfoBigCard(
                              firstText: "42",
                              secondText: BrandStrings.severeIssues,
                              icon: Icon(
                                LineAwesomeIcons.exclamation_triangle,
                                size: 32,
                                color: BrandColors.blueColor,
                              ),
                            ),
                          ],
                        ),

                        /// third row
                        TableRow(
                          children: [
                            // critical issues
                            ProfileInfoBigCard(
                              firstText: "404",
                              secondText: BrandStrings.criticalIssues,
                              icon: Icon(
                                LineAwesomeIcons.eye,
                                size: 32,
                                color: BrandColors.blueColor,
                              ),
                            ),

                            /// super likes me
                            GestureDetector(
                              onTap: () {
                                // do something here
                              },
                              child: ProfileInfoBigCard(
                                firstText: "42",
                                secondText: BrandStrings.successEvent,
                                icon: Icon(
                                  LineAwesomeIcons.heart,
                                  size: 32,
                                  color: BrandColors.blueColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // progress fill
          Positioned(
            top: screenHeight * (3 / 8) - 80 / 2,
            left: 16.0,
            right: 16.0,
            child: SizedBox(
              height: 80.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ProfileInfoCard(
                    firstText: "84%",
                    secondText: BrandStrings.progress,
                  ),
                  const SizedBox(width: 10.0),
                  const ProfileInfoCard(
                    hasImage: true,
                    imagePath: Assets.iconsPulse,
                  ),
                  const SizedBox(width: 10.0),
                  ProfileInfoCard(
                    firstText: "152",
                    secondText: BrandStrings.level,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
