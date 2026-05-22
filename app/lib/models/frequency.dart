enum Frequency {
  onceADay,
  twiceADay,
  asNeeded;

  String toDisplayString(dynamic l10n) {
    switch (this) {
      case Frequency.onceADay:
        return l10n.onceADay;
      case Frequency.twiceADay:
        return l10n.twiceADay;
      case Frequency.asNeeded:
        return l10n.asNeeded;
    }
  }
}
