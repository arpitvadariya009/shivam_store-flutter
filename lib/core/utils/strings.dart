import 'package:shivam_stores/services/hive_service.dart';

class Strings {
  static const String kRegisterNow = "Register Now!";
  static const String kFirmName = "Firm Name";
  static const String kCity = "City";
  static const String kMobileNumber = "Mobile Number";
  static const String kPIN = "PIN";
  static const String kIAgreewithTermPrivcy =
      "I Agree with Terms of Service and Privacy Policy";
  static const String kRegister = "Register";
  static const String kAlreadyhaveanaccount = "Already have an account? ";
  static const String kSignIn = "Sign In";
  static const String kSignUp = "Sign Up";
  static const String kResetPIN = "Reset PIN?";
  static const String kSHOW = "SHOW";
  static const String kHIDE = "HIDE";
  static const String kLoginNow = "Login Now!";
  static const String kLogin = "Login";
  static const String kPleaseacceptthePrivacyPolicytocontinue =
      "Please accept the Privacy Policy to continue.";
  static const String kDonthaveanaccountSignUp = "Don’t have an account? ";
  static const String kVerifying = "Verifying";
  static const String kWellgetbacktoyoushortly =
      "We’ll get back to you shortly";
  static const String kWeareverifyingyourstore =
      "We are verifying your store and we will reach out to you in 48 business hours";
  static const String kHome = "Home";
  static const String kEnter = "Enter ";
  static const String kEnteryour10digitnumber = "Enter your 10-digit number";
  static const String kPleaseentermobilenumber = "Please enter mobile number";
  static const String kMobilenumbermustbeexactly10digits =
      "Mobile number must be exactly 10 digits";
  static const String kPleaseentera = "Please enter a ";
  static const String kWelcometoShivamStores = "Welcome to Shivam Stores!";
  static const String kShop = "Shop";
  static const String kCart = "Cart";
  static const String kOrders = "Orders";
  static const String kVerification = "Verification";

  static const String kIMITATION = "IMITATION";
  static const String kYourCart = "Your Cart";
  static const String kMyOrders = "My Orders";
  static const String kAccount = "Account";
  static const String kCancled = "Cancled";
  static const String kActive = "Active";
  static const String kProfile = "Profile";
  static const String kCompleted = "Completed";
  static const String kProducts = "Products";
  static const String kTrackStatus = "Track Status";
  static const String kStaff = "Staff";
  static const String kCustomer = "Customer";
  static const String kManageOrders = "Manage Orders";
  static const String kStatusUpdate = "Status Update";
  static const String kInProcess = "In Process";
  static const String kOutforDelivery = "Out for Delivery";
  static const String kDelivered = "Delivered";

  static const String kUpdate = "Update";
  static const String kPending = "Pending";
  static const String kDone = "Done";
  static const List<String> svgIcons = [
    "assets/image/home.svg",
    "assets/image/order.svg",
    "assets/image/profile.svg",
  ];
  static const List<Map> status = [
    {'status': kInProcess, 'id': '1'},
    {'status': kDone, 'id': '2'},
  ];

  static List<String> labels = [kHome, kOrders, kAccount];
  static List<String> titledashboard = [
    kWelcometoShivamStores,
    HiveService().getValue(HiveService.isStaff) == true
        ? Strings.kManageOrders
        : kMyOrders,
    kProfile,
  ];
  static const List<String> kOrderStatus = [kActive, kCompleted, kCancled];

  static const List homeData = [
    {'name': 'Imitations', 'image': 'assets/image/lmitations.png'},
    {'name': 'Cosmetics', 'image': 'assets/image/cosmetics.png'},
    {'name': 'Swiss Beauty', 'image': 'assets/image/swiss_beauty.png'},
    {'name': 'Swiss Beauty', 'image': 'assets/image/swiss_beauty.png'},
    {'name': 'Hilary Rhoda', 'image': 'assets/image/hilary_rhoda.png'},
    {'name': 'Hilary Rhoda', 'image': 'assets/image/hilary_rhoda.png'},
    {'name': 'Hilary Rhoda', 'image': 'assets/image/hilary_rhoda.png'},
  ];
  static const List shopData = [
    {'name': 'Earrings', 'image': 'assets/image/earrings.png'},
    {'name': 'Necklaces', 'image': 'assets/image/necklaces.png'},
    {'name': 'Rings', 'image': 'assets/image/rings.png'},
    {'name': 'Bracelets', 'image': 'assets/image/bracelets.png'},
    {'name': 'Pendants', 'image': 'assets/image/pendants.png'},
    {'name': 'Hair Accessories', 'image': 'assets/image/hair_accessories.png'},
  ];
  static const List<Map<String, dynamic>> cartData = [
    {
      'title': 'Earrings - 1005',
      'set': 6,
      'selectedDesign': 4,
      'totalPiece': 24,
      'image': 'assets/image/earrings.png',
    },
    {
      'title': 'Lipstick - 1006',
      'set': 4,
      'selectedDesign': 5,
      'totalPiece': 20,
    },
    {
      'title': 'Pendats - 3625',
      'set': 6,
      'selectedDesign': 4,
      'totalPiece': 24,
    },
    {'title': 'Rings - 2086', 'set': 6, 'selectedDesign': 4, 'totalPiece': 24},
    {
      'title': 'Necklace - 5008',
      'set': 6,
      'selectedDesign': 4,
      'totalPiece': 24,
    },
    {
      'title': 'Earrings - 1008',
      'set': 6,
      'selectedDesign': 4,
      'totalPiece': 24,
    },
  ];
}
