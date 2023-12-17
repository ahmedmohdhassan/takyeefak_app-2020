class CalculatorBrain {
  CalculatorBrain(
      {this.length,
      this.width,
      this.height,
      this.selectedClimate,
      this.selectedClosing,
      this.selectedContent});

  num length;
  num width;
  num height;
  String selectedContent;
  String selectedClimate;
  String selectedClosing;
  num _roomvol;
  dynamic hPower;
  num result;
  String case1 = 'تحتاج الى تكييف صحراوي بمواصفات خاصة';
  String case2 = 'تحتاج الي اكثر من تكييف لضمان افضل جودة';

  num volCalculator() {
    if (length == null || width == null || height == null) {
      return _roomvol = null;
    } else if (length == 0 || width == 0 || height == 0) {
      return _roomvol = null;
    } else {
      num _roomvol = length * width * height;
      return _roomvol;
    }
  }

  num contentCalculator() {
    if (selectedContent == 'فارغة') {
      return result = 0;
    } else if (selectedContent == 'متوسطة') {
      return result = -1;
    } else if (selectedContent == 'ممتلئة') {
      return result = -2;
    }
    return result;
  }

  num closureCalculator() {
    if (selectedClosing == 'محكم') {
      return result = 0;
    } else if (selectedClosing == 'متوسط') {
      return result = 2;
    } else if (selectedClosing == 'منعدم') {
      return result = 5;
    }
    return result;
  }

  num finalCalculator() {
    if (selectedClimate == 'عادي') {
      if (volCalculator() == null) {
        return 0;
      } else {
        return volCalculator() + contentCalculator() + closureCalculator();
      }
//      return volCalculator() + contentCalculator() + closureCalculator();
    } else {
      return 4004;
    }
  }

  dynamic horsePower() {
    if (finalCalculator() == 4004) {
      return hPower = 'تحتاج الى تكييف صحراوي بمواصفات خاصة';
    } else if (finalCalculator() > 0 && finalCalculator() <= 35) {
      return hPower = 1.25;
    } else if (finalCalculator() > 35 && finalCalculator() <= 45) {
      return hPower = 1.50;
    } else if (finalCalculator() > 45 && finalCalculator() <= 65) {
      return hPower = 2.25;
    } else if (finalCalculator() > 65 && finalCalculator() <= 90) {
      return hPower = 3;
    } else if (finalCalculator() > 90 && finalCalculator() <= 120) {
      return hPower = 4;
    } else if (finalCalculator() > 120 && finalCalculator() <= 150) {
      return hPower = 5;
    } else if (finalCalculator() > 150 && finalCalculator() <= 180) {
      return hPower = 6;
    } else if (finalCalculator() > 180 && finalCalculator() <= 225) {
      return hPower = 7;
    } else if (finalCalculator() > 225) {
      return hPower = 'تحتاج الي اكثر من تكييف لضمان افضل جودة';
    } else if (finalCalculator() == 0) {
      return hPower = 'من فضلك ادخل قيم صحيحة';
    }
  }
}

//double.tryParse(case1)
