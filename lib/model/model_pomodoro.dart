class Pomodoro {

  static Pomodoro? actualPomodoro;
  int duration;
  int workTime;
  int shortBreakTime;
  int longBreakTime;
  int cantLongBreak = 0;
  int cantshortBreak = 0;
  int cantWorkTime = 0;
  List<int> sessions = [];

  Pomodoro({
    this.duration = 0,
    this.workTime = 25,
    this.shortBreakTime = 5,
    this.longBreakTime = 15,
    this.cantLongBreak = 0,
    this.cantshortBreak = 0,
    this.cantWorkTime = 0, 
  }) {
    if (duration == 0){
      duration = workTime*cantWorkTime;
    }

    calculatePomodoroSessions();
  }

  void calculatePomodoroSessions() {

    int remainingTime = duration;
    int contShort = 0;
    
    while (remainingTime > 0) {
      sessions.add(workTime);
      remainingTime -= workTime;

      if (contShort < 2){
        if (remainingTime > 0) {
          sessions.add(shortBreakTime);
          contShort++;
        }
      } else {
        if (remainingTime > 0) {
          sessions.add(longBreakTime);
          contShort = 0;
        }
      }

      if (remainingTime < workTime) {
        sessions.add(remainingTime);
        remainingTime =- remainingTime;
      }
    }
  }

  void setPomodoroSessions() {

    int remainingTime = duration;
    int contShort = 0;
    
    while (remainingTime > 0) {
      sessions.add(workTime);
      remainingTime -= workTime;

      if (contShort < 2){
        if (remainingTime > 0) {
          sessions.add(shortBreakTime);
          contShort++;
        }
      } else {
        if (remainingTime > 0) {
          sessions.add(longBreakTime);
          contShort = 0;
        }
      }

      if (remainingTime < workTime) {
        sessions.add(remainingTime);
        remainingTime =- remainingTime;
      }
    }
  }
}

