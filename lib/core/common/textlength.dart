import '../../model/total-credit-model.dart';
import '../../model/total-withdrawal-model.dart';

String formatWithLineBreaks(String text, int maxLineLength) {
  final buffer = StringBuffer();
  int count = 0;

  for (int i = 0; i < text.length; i++) {
    buffer.write(text[i]);
    count++;
    if (count >= maxLineLength && text[i] == 'No description added') {
      buffer.write('\n');
      count = 0;
    }
  }
  return buffer.toString();
}


