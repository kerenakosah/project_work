import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:projectwork/index.dart';

class PatientPage extends ConsumerStatefulWidget {
  // page id
  static const id = BrandStrings.patientPage;
  const PatientPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => PatientPageState();
}

class PatientPageState extends ConsumerState<PatientPage> {
  @override
  Widget build(BuildContext context) {
    final themeController = ref.watch(themeProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Patient Page',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: themeController.darkTheme ? BrandColors.white : BrandColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
