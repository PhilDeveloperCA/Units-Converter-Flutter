class Unit {
  int L;
  int M;
  int S;
  String type;
  double conv;
  String operation;

  Unit(this.L, this.M, this.S, this.type, this.conv, {this.operation = 'mul'});

  operator *(Unit other) {
    return new Unit(this.L + other.L, this.M + other.M, this.S + other.S, '',
        this.conv * other.conv);
  }

  operator /(Unit other) {
    return new Unit(this.L - other.L, this.M - other.M, this.S - other.S, '',
        this.conv / other.conv);
  }

  operator +(Unit other) {
    if (getType(this) == getType(other)) {
      return new Unit(this.L, this.M, this.S, '', this.conv + other.conv);
    }
  }

  operator -(Unit other) {
    if (getType(this) == getType(other)) {
      return new Unit(this.L, this.M, this.S, '', this.conv - other.conv);
    }
  }

  convToBase() {
    return conv;
  }

  static convIntegerToUnit(double number) {
    return new Unit(0, 0, 0, '', number);
  }

  static Unit Joule = new Unit(2, 1, -2, 'Energy', 1);
  static Unit Newton = new Unit(1, 1, -2, 'Force', 1);
  static Unit Watts = new Unit(2, 1, -3, 'Power', 1);
  static Unit Grams = new Unit(0, 1, 0, 'Mass', 1);
  static Unit Meter = new Unit(1, 0, 0, 'Length', 1);
  static Unit Seconds = new Unit(0, 0, 1, 'Time', 1);
  static Unit mps =
      new Unit(1, 0, -1, 'Velocity', 1); //Think about Selected Answer m/s
  static List<Unit> BaseUnits = [
    Newton,
    Joule,
    Watts,
    Grams,
    Meter,
    Seconds,
    mps
  ];

  //Other Units
  static Unit hours = new Unit(0, 0, 1, 'Time', 3600);
  static Unit HorsePower = new Unit(2, 1, -3, '', 745.7);
  static Unit PoundMass = new Unit(0, 1, 0, 'Mass', .4536);
  static Unit ft = new Unit(1, 0, 0, 'Length', .3048);
  static Unit slugs = new Unit(0, 1, 0, 'Mass', 14.5939);

  double convToOther(Unit) {
    return this.conv / Unit.conv;
  }

  static bool compareSide(Unit LS, Unit RS) {
    return LS.L == RS.L && LS.M == RS.M && LS.S == RS.S;
  }

  static String getType(Unit input) {
    String typeofUnit = '';
    for (final Unit in BaseUnits) {
      if (compareSide(input, Unit)) {
        return Unit.type;
      }
    }
    return typeofUnit;
  }

  void setType() {
    this.type = getType(this);
  } //This should be an instance function..

  static double calculate(Unit LS, Unit Answer) {
    if (compareSide(LS, Answer)) {
      return LS.conv / Answer.convToBase();
    }
    return 1.00;
  }

  static Map<String, Unit> UnitSearchTerms = {
    'g': Unit.Grams,
    'grams': Unit.Grams,
    's ': Unit.Seconds,
    'sec': Unit.Seconds,
    'seconds': Unit.Seconds,
    'n': Unit.Newton,
    'newtons': Unit.Newton,
    'ft/s': Unit.ft / Unit.Seconds,
    'ft per second': Unit.ft / Unit.Seconds,
    'feet/s': Unit.ft / Unit.Seconds,
    'feet per second': Unit.ft / Unit.Seconds,
  };

  static UnitSearch(String term) {
    return Unit.UnitSearchTerms.keys
        .toList()
        .where((key) => key.startsWith(term))
        .toList()
        .map((name) => {"name": name, "unit": Unit.UnitSearchTerms[name]})
        .toList();
  }
}
