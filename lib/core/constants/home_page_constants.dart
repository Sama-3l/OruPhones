import 'package:oruphones/assets/svgs/svg.dart';

const options = [
  "Buy Used Phones",
  "Sell Used Phones",
  "Compare Prices",
  "My Profile",
  "My Listings",
  "Open Store",
  "Services",
  "Device Health Check",
  "Battery Health Check",
  "IMEI Verification",
  "Device Details",
  "Data Wipe",
  "Under Warranty Phones",
  "Premium Phones",
  "Like New Phones",
  "Refurbished Phones",
  "Verified Phones",
  "My Negotiations",
  "My Favourites",
];

List<Map<String, dynamic>> chipCards = [
  {
    "title": "Sell Used Phones",
  },
  {
    "title": "Buy Used Phones",
  },
  {
    "title": "Compare Prices",
  },
  {
    "title": "My Profile",
  },
  {
    "title": "My Listings",
  },
  {
    "title": "Services",
  },
  {
    "title": "Register your Store",
    "new": true,
  },
  {
    "title": "Get the App",
  }
];

final List<Map<String, dynamic>> drawerOptions = [
  {
    "icon": howToBuy,
    "text": "How to Buy"
  },
  {
    "icon": howToSell,
    "text": "How to Sell"
  },
  {
    "icon": oruGuide,
    "text": "Oru Guide",
    "loggedInIcon": faqs,
    "loggedInText": "FAQs",
  },
  {
    "icon": aboutUs,
    "text": "About Us"
  },
  {
    "icon": privacyPolicy,
    "text": "Privacy Policy"
  },
  {
    "icon": faqs,
    "text": "FAQs",
    "loggedInIcon": returnPolicy,
    "loggedInText": "Return Policy",
  },
];
