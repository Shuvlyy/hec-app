import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hec_app/core/constants.dart';
import 'package:hec_app/core/router.dart';
import 'package:hec_app/l10n/app_localizations.dart';

class App extends ConsumerWidget
{
  const App({ super.key });

  @override
  Widget build(BuildContext context, WidgetRef ref)
  {
    final router = ref.watch(routerProvider);

    return CupertinoApp.router(
      routerConfig: router,
      title: Constants.appName,
      debugShowCheckedModeBanner: true,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // theme: Theme.light(),
      // darkTheme: Theme.dark(),
    );
  }
}
