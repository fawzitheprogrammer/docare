// class DateAndTime {
//    int daysInMonth(DateTime date) {
//     var firstDayThisMonth = DateTime(date.year, date.month, date.day);
//     var firstDayNextMonth = DateTime(firstDayThisMonth.year,
//         firstDayThisMonth.month + 1, firstDayThisMonth.day);
//     return firstDayNextMonth.difference(firstDayThisMonth).inDays;
//   }

//   // Take the input year, month number, and pass it inside DateTime()
//   final now = DateTime(2020, 7);

//   // Getting the total number of days of the month
//   int totalDays = daysInMonth(now);

//   // Stroing all the dates till the last date
//   // since we have found the last date using generate
//   var listOfDates = List<int>.generate(totalDays, (i) => i + 1);
// }
