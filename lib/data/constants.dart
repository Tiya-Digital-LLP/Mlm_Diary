class Constants {
  ///Local storage constants
  static String accessToken = 'access_token';
  static String isLoggedIn = 'is_logged_in';

  ///API Constants
  ///Base URLs
  static const String baseUrl = "https://laravel.mlmdiary.com/api";

  ///End Points
  static const String getUserType = "/getusertype";
  static const String domesticPhoneOtp = "/register/domestic_phone_otp";
  static const String foreignPhoneOtp = "/register/foreign_phone_otp";
  static const String resentOtp = "/register/resent_otp_register";
  static const String verifyphoneOtp = "/register/verify_phone_otp";
  static const String emailotp = "/register/email_otp";
  static const String verifyotp = "/register/email_verify";
  static const String userregister = "/user/register";
  static const String getplanlist = "/getplan";
  static const String savecompany = "/user/savecompany";
  static const String login = "/user/login";
  static const String forgotpassword = "/user/forgotpassword_otp";
  static const String changepassword = "/user/changepassword";
  static const String termsandcondition = "/termscondition";
  static const String userprofile = "/getuserprofile";
  static const String updateuserprofile = "/updateuserprofile_step1";
  static const String sendphoneotp = "/updatePhonenoRequest";
  static const String updateverifphoneotp = "/updatePhonenoVerify";
  static const String updatesocialmedia = "/updateSocialMedia";
  static const String updateemail = "/changeemailRequest";
  static const String updateemailphoneotp = "/updateEmailVerify";
}
