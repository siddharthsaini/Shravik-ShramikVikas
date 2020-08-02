import 'package:flutter/material.dart';
import 'package:share/share.dart';

Widget shareIcon(Icon icon) {
  return IconButton(
    iconSize: 35,
    icon: icon,
    onPressed: share,
  );
}

share() {
  Share.share(
    "*SHRAVIK: SHRAMIK VIKAS APP* is a platform for *Migrant Workers* and *Employers* to search and contact each other during these hard times.\n\n" +
        "People desperately looking to sustain their livelihood by *getting jobs closer to their homes* and those who *want to employ labour to sustain their business* should *REGISTER*\n\n" +
        "Users can be searched with *easy filters* and their *location and distance is displayed on the map*.\n\n" +
        "Click this link to *install* the app https://play.google.com/store/apps/details?id=tech.siddharthsaini.shravik\n\n" +
        "*श्रविक: श्रमिक विकास एप्लिकेशन* इन कठिन समय के दौरान एक दूसरे को खोजने और संपर्क करने के लिए *प्रवासी श्रमिक* और *उद्यमियों* के लिए एक मंच है।\n\n" +
        "उपयोगकर्ताओं को *आसान फ़िल्टर* के साथ खोजा जा सकता है और *उनके स्थान और दूरी को मानचित्र पर प्रदर्शित* किया जाता है।\n\n" +
        "जो लोग *अपने घरों के करीब रोजगार प्राप्त करके अपनी आजीविका को बनाए रखने के लिए उत्सुकता से देख रहे हैं, और जो लोग अपने व्यवसाय को बनाए रखने के लिए श्रम नियोजित करना चाहते हैं*, वे लोग शामिल हो सकते हैं|\n\n" +
        "इस *लिंक* पर क्लिक करें और एप्लिकेशन *इंस्टॉल* करें https://play.google.com/store/apps/details?id=tech.siddharthsaini.shravik",
  );
}
