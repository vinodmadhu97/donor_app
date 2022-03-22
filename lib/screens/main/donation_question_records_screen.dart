import 'package:donor_app/widgets/template/main/domation_question_records_template.dart';
import 'package:flutter/material.dart';

class DonationQuestionRecordsScreen extends StatelessWidget {
  final String campaignId;
  DonationQuestionRecordsScreen({Key? key, required this.campaignId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DonationQuestionRecordsTemplate(campaignId: campaignId);
  }
}
