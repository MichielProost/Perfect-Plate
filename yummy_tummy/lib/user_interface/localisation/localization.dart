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

  static final Localization _instance = Localization._privateConstructor();

  static Localization get instance => _instance;

  void setLanguage( LanguagePick language )
  {
    switch (language){
      case LanguagePick.english:
        this.language = English();
        break;
      case LanguagePick.dutch:
        this.language = Dutch();
        break;
    }
  }

}