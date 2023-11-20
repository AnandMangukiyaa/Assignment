part of 'utils.dart';

class ThemeUtils {
  ThemeUtils._();

  static ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.primary,
      hintColor: AppColors.darkGrey.withOpacity(0.5),
      backgroundColor: AppColors.backgroundColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      fontFamily: AppFontFamily.poppins,
      splashColor: Colors.white.withOpacity(0.1),
      highlightColor: Colors.white.withOpacity(0.1),
      unselectedWidgetColor: Colors.grey.shade400,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.secondary,
        selectionColor: AppColors.secondary.withOpacity(0.1),
        selectionHandleColor: AppColors.secondary,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.primary,
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w600),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      colorScheme: ColorScheme.fromSwatch(
              primarySwatch: generateMaterialColor(AppColors.primary))
          .copyWith(secondary: AppColors.secondary),
    );
  }
}
