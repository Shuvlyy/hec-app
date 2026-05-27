enum Frequency {
  onceADay,
  twiceADay,
  threeTimesADay,
  onceAWeek,
  asNeeded;

  String toDisplayString(dynamic l10n) {
    switch (this) {
      case Frequency.onceADay:
        return l10n.onceADay;
      case Frequency.twiceADay:
        return l10n.twiceADay;
      case Frequency.threeTimesADay:
        return l10n.threeTimesADay;
      case Frequency.onceAWeek:
        return l10n.onceAWeek;
      case Frequency.asNeeded:
        return l10n.asNeeded;
    }
  }
}
