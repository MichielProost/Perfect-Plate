import 'language.dart';
import 'english.dart';
import 'dutch.dart';

enum LanguagePick {
  english,
  dutch,
  other
}

class Localization {

  Localization._privateConstructor();

  Language language = English();
  LanguagePick _languagePick = LanguagePick.english;

  LanguagePick get languagePick => _languagePick; 

  static final Localization _instance = Localization._privateConstructor();

  static Localization get instance => _instance;

  void setLanguage( LanguagePick language )
  {
    // print('Setting $languagePick to $language');
    _languagePick = language;
    switch (language){
      case LanguagePick.english:
        this.language = English();
        break;
      case LanguagePick.dutch:
        this.language = Dutch();
        break;
      case LanguagePick.other:
        this.language = English();
        break;
    }
  }

}