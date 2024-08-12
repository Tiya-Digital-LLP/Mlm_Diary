# ProGuard rules for your application

# Ignore warnings about missing R classes
-dontwarn **.R$*

# Keep all classes in the Google Play services library
-keep class com.google.android.gms.** { *; }

# Keep all classes in the Firebase library
-keep class com.google.firebase.** { *; }
