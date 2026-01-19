extension DurationFormatter on int {
  String toMinSecond() {
    final minutes = this ~/ 60;
    final seconds = this % 60;

    // Pad minutes and seconds with leading zeros if necessary
    final formattedMinutes = minutes.toString().padLeft(2, '0');
    final formattedSeconds = seconds.toString().padLeft(2, '0');

    return "$formattedMinutes:$formattedSeconds";
  }


}

extension StringExtensions on String? {

  // String capitalize() {
  //   if (this.isEmpty) return this;
  //   return this[0].toUpperCase() + this.substring(1);
  // }
  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }
  bool isWhatsAppLink() {
    if(this.isNullOrEmpty()){
      return false;
    }

    // Convert to lowercase for consistent checking

    // Common WhatsApp URL patterns
    final whatsappPatterns = [
      RegExp(r'^https?:\/\/(www\.)?(api\.)?wa\.me\/'),
      RegExp(r'^https?:\/\/(www\.)?whatsapp\.com\/'),
      RegExp(r'^whatsapp:\/\/'),
      RegExp(r'^https?:\/\/(www\.)?web\.whatsapp\.com\/'),
    ];

    // Check if the link matches any WhatsApp pattern
    return whatsappPatterns.any((pattern) => pattern.hasMatch(this!.toLowerCase()));
  }

}

