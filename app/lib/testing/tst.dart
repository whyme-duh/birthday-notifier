String? HoroscopeFinder(String GivenDate) {
  DateTime givenDate = DateTime.parse(GivenDate);

  // seperating the year, month and day from the given date
  int givenMonth = givenDate.month;
  int givenDay = givenDate.day;
  if ((givenMonth == 3 && givenDay >= 21) ||
      (givenMonth == 4 && givenDay <= 19)) {
    return "Aries";
  }
  if ((givenMonth == 4 && givenDay >= 20) ||
      (givenMonth == 5 && givenDay <= 20)) {
    return "Taurus";
  }
  if ((givenMonth == 5 && givenDay >= 21) ||
      (givenMonth == 6 && givenDay <= 20)) {
    return "Gemini";
  }
  if ((givenMonth == 6 && givenDay >= 21) ||
      (givenMonth == 7 && givenDay <= 22)) {
    return "Cancer";
  }
  if ((givenMonth == 7 && givenDay >= 23) ||
      (givenMonth == 8 && givenDay <= 22)) {
    return "Leo";
  }
  if ((givenMonth == 8 && givenDay >= 23) ||
      (givenMonth == 9 && givenDay <= 22)) {
    return "Virgo";
  }
  if ((givenMonth == 9 && givenDay >= 23) ||
      (givenMonth == 10 && givenDay <= 22)) {
    return "Libra";
  }
  if ((givenMonth == 10 && givenDay >= 23) ||
      (givenMonth == 11 && givenDay <= 21)) {
    return "Scorpio";
  }
  if ((givenMonth == 11 && givenDay >= 22) ||
      (givenMonth == 12 && givenDay <= 21)) {
    return "Sagittarius";
  }
  if ((givenMonth == 12 && givenDay >= 22) ||
      (givenMonth == 1 && givenDay <= 19)) {
    return "Capricorn";
  }
  if ((givenMonth == 1 && givenDay >= 20) ||
      (givenMonth <= 2 && givenDay <= 18)) {
    return "Aquarius";
  }

  if ((givenMonth == 2 && givenDay >= 19) ||
      (givenMonth == 3 && givenDay <= 20)) {
    return "Pisces";
  }
  return 'ERROR';
}

String AgeDifffernce(String GivenDate) {
  // taken from the user

  // changing the inputed date into the datetime instance
  DateTime givenDate = DateTime.parse(GivenDate);

  // current date
  DateTime now = DateTime.now();

  // seperating the year, month and day from the given date
  int givenYear = givenDate.year;
  int givenMonth = givenDate.month;
  int givenDay = givenDate.day;

  // seperating the year, month and day from the current date
  int currentYear = now.year;
  int currentMonth = now.month;
  int currentDay = now.day;

  // year difference
  int YearDiff = (currentYear - givenYear);
  int MnthDiff = (currentMonth - givenMonth).abs();
  int DayDiff = (currentDay - givenDay).abs();

  // birthday passed
  int actaulYear = YearDiff - 1;
  int actualMonth = 12 - MnthDiff;
  int birthdayIncomingDays = 0;
  if (currentMonth == 1 ||
      currentMonth == 3 ||
      currentMonth == 5 ||
      currentMonth == 7 ||
      currentMonth == 8 ||
      currentMonth == 10 ||
      currentMonth == 12) {
    birthdayIncomingDays = (DayDiff - 31).abs();
  } else if (currentMonth == 4 ||
      currentMonth == 6 ||
      currentMonth == 9 ||
      currentMonth == 11) {
    birthdayIncomingDays = (DayDiff - 30).abs();
  } else {
    birthdayIncomingDays = (DayDiff - 28).abs();
  }

  // for displaying the age of the user
  // birthday is incoming
  if (givenMonth < currentMonth) {
    return ("$YearDiff year, $MnthDiff month and $DayDiff days");
  } else if (givenMonth == currentMonth && givenDay < currentDay) {
    return ("$YearDiff year, $MnthDiff month and $DayDiff days ");
  }
  // birthdate has been passed
  else {
    return ("$actaulYear year, $actualMonth months and $birthdayIncomingDays days");
  }
}

bool birthdayOrNot(String GivenDate) {
  // taken from the user

  // changing the inputed date into the datetime instance
  DateTime givenDate = DateTime.parse(GivenDate);

  // current date
  DateTime now = DateTime.now();

  // seperating the year, month and day from the given date
  int givenYear = givenDate.year;
  int givenMonth = givenDate.month;
  int givenDay = givenDate.day;

  // seperating the year, month and day from the current date
  int currentYear = now.year;
  int currentMonth = now.month;
  int currentDay = now.day;

  // year difference
  int YearDiff = (currentYear - givenYear).abs();
  int MnthDiff = (currentMonth - givenMonth).abs();
  int DayDiff = (currentDay - givenDay).abs();

// birthday passed
  int actaulYear = YearDiff - 1;
  int actualMonth = 12 - MnthDiff;
  bool isTrue = true;
  if (currentMonth == givenMonth && currentDay == givenDay) {
    YearDiff += 1;
    actualMonth = 0;
    return true;
  } else {
    return false;
  }
}

String RemainingDaysForBirthday(String GivenDate) {
// changing the inputed date into the datetime instance
  DateTime givenDate = DateTime.parse(GivenDate);

  // current date
  DateTime now = DateTime.now();
  // adding extra months
  int extra = 0;
  // for adding days for the remaining days
  int remdays = 0;

  // seperating the year, month and day from the given date
  int givenYear = givenDate.year;
  int givenMonth = givenDate.month;
  int givenDay = givenDate.day;

  // seperating the year, month and day from the current date
  int currentYear = now.year;
  int currentMonth = now.month;
  int currentDay = now.day;

  // year difference
  int YearDiff = (currentYear - givenYear);
  int MnthDiff = (givenMonth - currentMonth).abs();
  int DayDiff = (currentDay - givenDay).abs();

  // birthday passed
  int actaulYear = YearDiff - 1;
  int actualMonth = 12 - MnthDiff;
  // it gives the remaining month when the currrent month has exceeds givenMonth
  // gives the remaining days
  remdays = (currentDay - 30).abs() + givenDay;
  if (!birthdayOrNot(GivenDate)) {
    // if (MnthDiff > 0){
    //   return(" $MnthDiff months and $DayDiff days");

    // }
    // if the birthday is incoming
    if (MnthDiff == 0 && givenDay > currentDay) {
      return ("Only $DayDiff days ");
    }
    //if the birthday has passed
    else if (MnthDiff == 0 && givenDay < currentDay) {
      return ("$actualMonth months ");
    } else if (givenMonth > currentMonth) {
      // when the current day is less than actual birth day
      if (currentDay < givenDay) {
        return ("$MnthDiff months and $DayDiff days");
      } else {
        if (currentMonth == 1) {
          // rDay is the remainig days  for the birthday
          int rDay = (31 - currentDay) + givenDay;
          {
            return ("${MnthDiff - 1} months and $rDay days");
          }
        }
        if (currentMonth == 2) {
          int rDay = (28 - currentDay) + givenDay;
          {
            return ("${MnthDiff - 1} months and $rDay days");
          }
        }
        if (currentMonth == 3) {
          int rDay = (31 - currentDay) + givenDay;
          {
            return ("${MnthDiff - 1} months and $rDay days");
          }
        }
        if (currentMonth == 4) {
          int rDay = (30 - currentDay) + givenDay;
          {
            return ("${MnthDiff - 1} months and $rDay days");
          }
        }
        if (currentMonth == 5) {
          int rDay = (31 - currentDay) + givenDay;
          {
            return ("${MnthDiff - 1} months and $rDay days");
          }
        }
        if (currentMonth == 6) {
          int rDay = (30 - currentDay) + givenDay;
          {
            return ("${MnthDiff - 1} months and $rDay days");
          }
        }
        if (currentMonth == 7) {
          int rDay = (31 - currentDay) + givenDay;
          {
            return ("${MnthDiff - 1} months and $rDay days");
          }
        }
        if (currentMonth == 8) {
          int rDay = (31 - currentDay) + givenDay;
          {
            return ("${MnthDiff - 1} months and $rDay days");
          }
        }
        if (currentMonth == 9) {
          int rDay = (30 - currentDay) + givenDay;
          {
            return ("${MnthDiff - 1} months and $rDay days");
          }
        }
        if (currentMonth == 10) {
          int rDay = (31 - currentDay) + givenDay;
          {
            return ("${MnthDiff - 1} months and $rDay days");
          }
        }
        if (currentMonth == 11) {
          int rDay = (30 - currentDay) + givenDay;
          {
            return ("${MnthDiff - 1} months and $rDay days");
          }
        }
        if (currentMonth == 12) {
          int rDay = (31 - currentDay) + givenDay;
          {
            return ("${MnthDiff - 1} months and $rDay days");
          }
        }
        return ("Error!");
      }
    }
    // birthday passsed by some months
    else if (givenMonth < currentMonth) {
      givenMonth = (12 - currentMonth) + givenMonth;
      // if the current month is not 12
      if (currentDay < givenDay) {
        givenMonth = (12 - currentMonth) + givenMonth;

        return ("$givenMonth month and $DayDiff days");
      } else {
        if (currentMonth == 1) {
          // rDay is the remainig days  for the birthday
          int rDay = (31 - currentDay) + givenDay;
          {
            return ("${givenMonth - 1} months and $rDay days");
          }
        }
        if (currentMonth == 2) {
          int rDay = (28 - currentDay) + givenDay;
          {
            return ("${givenMonth - 1} months and $rDay days");
          }
        }
        if (currentMonth == 3) {
          int rDay = (31 - currentDay) + givenDay;
          {
            return ("${givenMonth - 1} months and $rDay days");
          }
        }
        if (currentMonth == 4) {
          int rDay = (30 - currentDay) + givenDay;
          {
            return ("${givenMonth - 1} months and $rDay days");
          }
        }
        if (currentMonth == 5) {
          int rDay = (31 - currentDay) + givenDay;
          {
            return ("${givenMonth - 1} months and $rDay days");
          }
        }
        if (currentMonth == 6) {
          int rDay = (30 - currentDay) + givenDay;
          {
            return ("${givenMonth - 1} months and $rDay days");
          }
        }
        if (currentMonth == 7) {
          int rDay = (31 - currentDay) + givenDay;
          {
            return ("${givenMonth - 1} months and $rDay days");
          }
        }
        if (currentMonth == 8) {
          int rDay = (31 - currentDay) + givenDay;
          {
            return ("${givenMonth - 1} months and $rDay days");
          }
        }
        if (currentMonth == 9) {
          int rDay = (30 - currentDay) + givenDay;
          {
            return ("${givenMonth - 1} months and $rDay days");
          }
        }
        if (currentMonth == 10) {
          int rDay = (31 - currentDay) + givenDay;
          {
            return ("${givenMonth - 1} months and $rDay days");
          }
        }
        if (currentMonth == 11) {
          int rDay = (30 - currentDay) + givenDay;
          {
            return ("${givenMonth - 1} months and $rDay days");
          }
        }
        if (currentMonth == 12) {
          int rDay = (31 - currentDay) + givenDay;
          {
            return ("${givenMonth - 1} months and $rDay days");
          }
        }
      }
      return ("$MnthDiff month and $remdays days");
    } else {
      return ("$remdays days");
    }
  } else {
    return "Today is their birthday!";
  }
}

String ReturnDate(String GivenDate) {
  DateTime givenDate = DateTime.parse(GivenDate);
  int givenYear = givenDate.year;
  int givenMonth = givenDate.month;
  int givenDay = givenDate.day;
  return ("$givenYear-$givenMonth-$givenDay");
}

bool validateDate(String GivenDate) {
  // changing the inputed date into the datetime instance
  DateTime givenDate = DateTime.parse(GivenDate);

  // current date
  DateTime now = DateTime.now();

  // seperating the year, month and day from the given date
  int givenYear = givenDate.year;
  int givenMonth = givenDate.month;
  int givenDay = givenDate.day;

  // seperating the year, month and day from the current date
  int currentYear = now.year;
  // int currentMonth = now.month;
  // int currentDay = now.day;

  // year difference
  int YearDiff = (currentYear - givenYear);

  if (YearDiff > 120) {
    return false;
  }
  if (givenYear > currentYear) {
    return false;
  }
  if (givenMonth > 12 || givenMonth <= 0) {
    return false;
  }
  if (givenDay <= 0 || givenDay > 31) {
    return false;
  } else {
    return true;
  }
}

void main() {
  print(RemainingDaysForBirthday("2000-02-12"));
}
