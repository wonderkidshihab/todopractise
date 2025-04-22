import 'package:intl/intl.dart';

String formatDatedMMMyyyy(DateTime date) {
  return DateFormat('d MMM, yyyy').format(date);
}
