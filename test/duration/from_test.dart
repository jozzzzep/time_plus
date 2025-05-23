import 'package:test/test.dart';
import 'package:time_plus/time_plus.dart';

void main() {
  group('DurationFrom static methods', () {
    test('microseconds', () {
      expect(DurationFrom.microseconds(123), Duration(microseconds: 123));
    });

    test('milliseconds', () {
      expect(DurationFrom.milliseconds(123), Duration(milliseconds: 123));
    });

    test('seconds', () {
      expect(DurationFrom.seconds(123), Duration(seconds: 123));
    });

    test('minutes', () {
      expect(DurationFrom.minutes(123), Duration(minutes: 123));
    });

    test('hours', () {
      expect(DurationFrom.hours(123), Duration(hours: 123));
    });

    test('days', () {
      expect(DurationFrom.days(123), Duration(days: 123));
    });

    test('weeks', () {
      expect(DurationFrom.weeks(2), Duration(days: 2 * DateTime.daysPerWeek));
    });

    test('months', () {
      expect(DurationFrom.months(3),
          Duration(days: (3 * TimePlusConsts.averageDaysPerMonth).round()));
    });

    test('years', () {
      expect(DurationFrom.years(4),
          Duration(days: (4 * TimePlusConsts.averageDaysPerYear).round()));
    });

    test('decades', () {
      expect(DurationFrom.decades(1),
          Duration(days: (1 * TimePlusConsts.averageDaysPerDecade).round()));
    });

    test('centuries', () {
      expect(DurationFrom.centuries(2),
          Duration(days: (2 * TimePlusConsts.averageDaysPerCentury).round()));
    });
  });

  group('DurationFrom static constants', () {
    test('microsecond', () {
      expect(DurationFrom.microsecond, Duration(microseconds: 1));
    });

    test('millisecond', () {
      expect(DurationFrom.millisecond, Duration(milliseconds: 1));
    });

    test('second', () {
      expect(DurationFrom.second, Duration(seconds: 1));
    });

    test('minute', () {
      expect(DurationFrom.minute, Duration(minutes: 1));
    });

    test('hour', () {
      expect(DurationFrom.hour, Duration(hours: 1));
    });

    test('day', () {
      expect(DurationFrom.day, Duration(days: 1));
    });

    test('week', () {
      expect(DurationFrom.week, Duration(days: DateTime.daysPerWeek));
    });

    test('month', () {
      expect(DurationFrom.month,
          Duration(days: TimePlusConsts.roundedDaysPerMonth));
    });

    test('year', () {
      expect(
          DurationFrom.year, Duration(days: TimePlusConsts.roundedDaysPerYear));
    });

    test('decade', () {
      expect(DurationFrom.decade,
          Duration(days: TimePlusConsts.roundedDaysInDecade));
    });

    test('century', () {
      expect(DurationFrom.century,
          Duration(days: TimePlusConsts.roundedDaysInCentury));
    });
  });

  group('DurationFrom edge case and consistency tests', () {
    test('negative values', () {
      expect(DurationFrom.years(-2),
          Duration(days: (-2 * TimePlusConsts.averageDaysPerYear).round()));
      expect(DurationFrom.centuries(-1), -DurationFrom.century);
    });

    test('zero values', () {
      expect(DurationFrom.seconds(0), Duration.zero);
      expect(DurationFrom.years(0), Duration.zero);
    });

    test('composability', () {
      final total = DurationFrom.week +
          DurationFrom.day +
          DurationFrom.hour +
          DurationFrom.minute +
          DurationFrom.second;

      final expected = Duration(
        days: DateTime.daysPerWeek + 1,
        hours: 1,
        minutes: 1,
        seconds: 1,
      );

      expect(total, expected);
    });

    test('manual consistency check with days', () {
      final threeMonths = DurationFrom.months(3);
      expect(
          threeMonths.inDays, (3 * TimePlusConsts.averageDaysPerMonth).round());
    });

    test('large values', () {
      expect(DurationFrom.centuries(1000).inDays,
          1000 * TimePlusConsts.averageDaysPerCentury);
      expect(DurationFrom.years(10000).inDays,
          10000 * TimePlusConsts.averageDaysPerYear);
    });

    test('very small values', () {
      expect(DurationFrom.microseconds(1), Duration(microseconds: 1));
      expect(DurationFrom.milliseconds(1), Duration(milliseconds: 1));
      expect(DurationFrom.seconds(1), Duration(seconds: 1));
    });

    test('complex duration combinations', () {
      final complex = DurationFrom.century +
          DurationFrom.decade +
          DurationFrom.year +
          DurationFrom.month +
          DurationFrom.week +
          DurationFrom.day +
          DurationFrom.hour +
          DurationFrom.minute +
          DurationFrom.second +
          DurationFrom.millisecond;

      final expected = Duration(
        days: TimePlusConsts.roundedDaysInCentury +
            TimePlusConsts.roundedDaysInDecade +
            TimePlusConsts.roundedDaysPerYear +
            TimePlusConsts.roundedDaysPerMonth +
            DateTime.daysPerWeek +
            1,
        hours: 1,
        minutes: 1,
        seconds: 1,
        milliseconds: 1,
      );

      expect(complex, expected);
    });

    test('mixed positive and negative values', () {
      final mixed = DurationFrom.century +
          DurationFrom.decade -
          DurationFrom.year +
          DurationFrom.month -
          DurationFrom.week;

      final expected = Duration(
        days: TimePlusConsts.roundedDaysInCentury +
            TimePlusConsts.roundedDaysInDecade -
            TimePlusConsts.roundedDaysPerYear +
            TimePlusConsts.roundedDaysPerMonth -
            DateTime.daysPerWeek,
      );

      expect(mixed, expected);
    });
  });
}
