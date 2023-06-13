/// Generated file. Do not edit.
///
/// Locales: 2
/// Strings: 36 (18 per locale)
///
/// Built on 2023-06-13 at 13:59 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, _StringsEn> {
	en(languageCode: 'en', build: _StringsEn.build),
	ru(languageCode: 'ru', build: _StringsRu.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, _StringsEn> build;

	/// Gets current instance managed by [LocaleSettings].
	_StringsEn get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
_StringsEn get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class Translations {
	Translations._(); // no constructor

	static _StringsEn of(BuildContext context) => InheritedLocaleData.of<AppLocale, _StringsEn>(context).translations;
}

/// The provider for method B
class TranslationProvider extends BaseTranslationProvider<AppLocale, _StringsEn> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, _StringsEn> of(BuildContext context) => InheritedLocaleData.of<AppLocale, _StringsEn>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	_StringsEn get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, _StringsEn> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, _StringsEn> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class _StringsEn implements BaseTranslations<AppLocale, _StringsEn> {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, _StringsEn> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final _StringsEn _root = this; // ignore: unused_field

	// Translations
	late final _StringsCommonwordsEn commonwords = _StringsCommonwordsEn._(_root);
	late final _StringsHomepageEn homepage = _StringsHomepageEn._(_root);
	late final _StringsTaskpageEn taskpage = _StringsTaskpageEn._(_root);
}

// Path: commonwords
class _StringsCommonwordsEn {
	_StringsCommonwordsEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get confirmation => 'Are you sure?';
	String get confirm => 'Confirm';
	String get cancel => 'Cancel';
}

// Path: homepage
class _StringsHomepageEn {
	_StringsHomepageEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get mytasks => 'My tasks';
	String get done => 'Is done';
	String get newtask => 'New task';
}

// Path: taskpage
class _StringsTaskpageEn {
	_StringsTaskpageEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get task => 'Task';
	String get name => 'Task name';
	String get description => 'Description';
	String get save => 'Save';
	String get until => 'Due date';
	String get until_short => 'Until';
	String get priority => 'Priority';
	String get low => 'Low';
	String get regular => 'Regular';
	String get hight => 'Hight';
	String get critical => 'Critical';
	String get delete => 'Delete';
}

// Path: <root>
class _StringsRu implements _StringsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsRu.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.ru,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ru>.
	@override final TranslationMetadata<AppLocale, _StringsEn> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsRu _root = this; // ignore: unused_field

	// Translations
	@override late final _StringsCommonwordsRu commonwords = _StringsCommonwordsRu._(_root);
	@override late final _StringsHomepageRu homepage = _StringsHomepageRu._(_root);
	@override late final _StringsTaskpageRu taskpage = _StringsTaskpageRu._(_root);
}

// Path: commonwords
class _StringsCommonwordsRu implements _StringsCommonwordsEn {
	_StringsCommonwordsRu._(this._root);

	@override final _StringsRu _root; // ignore: unused_field

	// Translations
	@override String get confirmation => 'Вы уверены?';
	@override String get confirm => 'Подтвердить';
	@override String get cancel => 'Отмена';
}

// Path: homepage
class _StringsHomepageRu implements _StringsHomepageEn {
	_StringsHomepageRu._(this._root);

	@override final _StringsRu _root; // ignore: unused_field

	// Translations
	@override String get mytasks => 'Мои задачи';
	@override String get done => 'Выполнено';
	@override String get newtask => 'Добавить';
}

// Path: taskpage
class _StringsTaskpageRu implements _StringsTaskpageEn {
	_StringsTaskpageRu._(this._root);

	@override final _StringsRu _root; // ignore: unused_field

	// Translations
	@override String get task => 'Задача';
	@override String get name => 'Название';
	@override String get description => 'Описание';
	@override String get save => 'Сохранить';
	@override String get until => 'Срок выполнения';
	@override String get until_short => 'До';
	@override String get priority => 'Приоритет';
	@override String get low => 'Низкий';
	@override String get regular => 'Обычный';
	@override String get hight => 'Высокий';
	@override String get critical => 'Критический';
	@override String get delete => 'Удалить';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _StringsEn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'commonwords.confirmation': return 'Are you sure?';
			case 'commonwords.confirm': return 'Confirm';
			case 'commonwords.cancel': return 'Cancel';
			case 'homepage.mytasks': return 'My tasks';
			case 'homepage.done': return 'Is done';
			case 'homepage.newtask': return 'New task';
			case 'taskpage.task': return 'Task';
			case 'taskpage.name': return 'Task name';
			case 'taskpage.description': return 'Description';
			case 'taskpage.save': return 'Save';
			case 'taskpage.until': return 'Due date';
			case 'taskpage.until_short': return 'Until';
			case 'taskpage.priority': return 'Priority';
			case 'taskpage.low': return 'Low';
			case 'taskpage.regular': return 'Regular';
			case 'taskpage.hight': return 'Hight';
			case 'taskpage.critical': return 'Critical';
			case 'taskpage.delete': return 'Delete';
			default: return null;
		}
	}
}

extension on _StringsRu {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'commonwords.confirmation': return 'Вы уверены?';
			case 'commonwords.confirm': return 'Подтвердить';
			case 'commonwords.cancel': return 'Отмена';
			case 'homepage.mytasks': return 'Мои задачи';
			case 'homepage.done': return 'Выполнено';
			case 'homepage.newtask': return 'Добавить';
			case 'taskpage.task': return 'Задача';
			case 'taskpage.name': return 'Название';
			case 'taskpage.description': return 'Описание';
			case 'taskpage.save': return 'Сохранить';
			case 'taskpage.until': return 'Срок выполнения';
			case 'taskpage.until_short': return 'До';
			case 'taskpage.priority': return 'Приоритет';
			case 'taskpage.low': return 'Низкий';
			case 'taskpage.regular': return 'Обычный';
			case 'taskpage.hight': return 'Высокий';
			case 'taskpage.critical': return 'Критический';
			case 'taskpage.delete': return 'Удалить';
			default: return null;
		}
	}
}
