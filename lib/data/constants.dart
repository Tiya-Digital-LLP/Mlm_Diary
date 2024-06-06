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
  static const String getbanner = "/getbanner";
  static const String getvideolist = "/videolist";
  static const String getcategorylist = "/getcategory";
  static const String getsubcategorylist = "/getsubcategory";
  static const String saveclassified = "/saveclassified";
  static const String manageclassified = "/myclassifiedlist";
  static const String getcompany = "/getcompany";
  static const String getclassified = "/getclassified";
  static const String likeduserclassified = "/addlikeclassified";
  static const String bookmarkclassified = "/addfavoriteclassified";
  static const String updateclassified = "/updateclassified";
  static const String delteclassified = "/deleteclassified";
  static const String getadmincompany = "/getmlmcompany";
  static const String likemlmcompany = "/likemlmcompany";
  static const String bookmarkmlmcompany = "/bookmark_mlmcompany";
  static const String mlmdatabase = "/getdatabase";
  static const String remainigclassifeidcount =
      "/remaining_classified_count_check";
  static const String news = "/addnews";
  static const String mynews = "/mynewslist";
  static const String deletenews = "/deletenews";
  static const String updatenews = "/updatenews";
  static const String likednews = "/addlikenews";
  static const String addblog = "/addblog";
  static const String myblog = "/mybloglist";
  static const String deleteblog = "/deleteblog";
  static const String likedblog = "/addlikeblog";
  static const String blogBookmark = "/addfavoriteblog";
  static const String updateblog = "/updateblog";

  static const String addpost = "/adduserpost";
  static const String editpost = "/updateuserpost";
  static const String mypost = "/mypostlist";
  static const String deletepost = "/deleteuserpost";
}
