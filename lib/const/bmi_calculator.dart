import 'dart:math';

class CalculateBMI{
  final int height;
  final int weight;
  final String? gender;
  double _bmi = 0;

  CalculateBMI({required this.height, required this.weight, this.gender});

  double getCalculation(){
    _bmi = weight/pow(height/100,2);
    return _bmi;
  }

  String getResult(double bmi){
    if(bmi >= 25){
      return "Over Weight";
    }
    else if(bmi > 18.5){
      return "Normal";
    }
    else{
      return "Under Weight";
    }
  }

  String getInterpretation(double bmi){
    if(bmi >= 25){
      return "You have a higher than normal body weight. Try to exercise more";
    }
    else if(bmi > 18.5){
      return "You have a normal body weight. good job.";
    }
    else{
      return "You have lower than normal body weight. You can eat a bit more";
    }
  }


}