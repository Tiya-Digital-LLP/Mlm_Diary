class Constants {
  ///Local storage constants
  static String accessToken = 'access_token';
  static String isLoggedIn = 'is_logged_in';
  static String userId = 'user_id';

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
  static const String getplanlistwithselected = "/getplanWithSelected";
  static const String getcompanylistwithselected = "/getCompanyWithSelected";

  static const String updateUserPlan = "/updateUserPlan";

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
  static const String likelistclassified = "/classified/likelist";
  static const String countviewclassified = "/countview_classified";
  static const String getcommentclassified = "/getclassified_comment";
  static const String addcommentreply = "/add_classified_comment";
  static const String deletecommment = "/deletecomment";
  static const String editcommment = "/editComment";
  static const String boostontopclassified = "/classified/request_to_top";
  static const String boostontopclassifiedpremium =
      "/classified/request_for_paid_classified";

  static const String getadmincompany = "/getmlmcompany";
  static const String countviewcompany = "/countview_company";

  static const String likemlmcompany = "/likemlmcompany";
  static const String bookmarkmlmcompany = "/bookmark_mlmcompany";
  static const String mlmdatabase = "/getdatabase";
  static const String countviewuserprofile = "/countview_database";
  static const String getcommentCompany = "/getcompany_comment";
  static const String addcommentcompanyreply = "/add_company_comment";

  static const String remainigcount = "/remaining_count_check";
  static const String news = "/addnews";
  static const String mynews = "/mynewslist";
  static const String getnews = "/getnews";
  static const String likelistnews = "/news/likelist";
  static const String countviewnews = "/countview_news";
  static const String deletenews = "/deletenews";
  static const String updatenews = "/updatenews";
  static const String getcommentnews = "/getnews_comment";
  static const String addcommentnewsreply = "/add_news_comment";

  static const String likednews = "/addlikenews";
  static const String bookmarknews = "/addfavoritenews";

  static const String addblog = "/addblog";
  static const String myblog = "/mybloglist";
  static const String deleteblog = "/deleteblog";
  static const String likedblog = "/addlikeblog";
  static const String blogBookmark = "/addfavoriteblog";
  static const String updateblog = "/updateblog";
  static const String getblog = "/getblog";
  static const String likelistblog = "/blog/likelist";
  static const String countviewblog = "/countview_blog";
  static const String getcommentblog = "/getblog_comment";
  static const String getcommentpost = "/getuserpost_comment";

  static const String addcommentblogreply = "/add_blog_comment";

  static const String addpost = "/adduserpost";
  static const String editpost = "/updateuserpost";
  static const String mypost = "/mypostlist";
  static const String userpost = "/databasedetail";

  static const String postlike = "/addlikepost";
  static const String deletepost = "/deleteuserpost";
  static const String bookmarkpost = "/addfavoritepost";
  static const String likelistpost = "/post/likelist";
  static const String profileBookmark = "/bookmark_database";
  static const String profileFollow = "/follow";
  static const String getFollowers = "/getfollowers";
  static const String getFollowing = "/getfollowing";
  static const String addcommentpostreply = "/add_post_comment";

  static const String addquestionanswer = "/addquestion";
  static const String myqusetionanswer = "/myquestion";
  static const String getquestion = "/getquestion";
  static const String getanswer = "/getanswers";
  static const String addanswer = "/addanswer";
  static const String likelistquestion = "/question/likelist";
  static const String countviewquestion = "/countview_question";
  static const String questionBookmark = "/addfavoritequestion";
  static const String likedquestion = "/addlikequestion";
  static const String likedanswer = "/addlikeanswer";
  static const String addcommentanswerreply = "/add_answer_comment";

  static const String allbookmark = "/getallbookmarked";

  static const String videoBookmark = "/bookmark_video";
  static const String tutorialVideo = "/gettutorial_video";
}
