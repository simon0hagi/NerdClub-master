void main(List<String> arguments) {
  Character robert =
      Character('Robert', [Item('Axt', 15)], [Item('Herzcontainer', 100)]);
  Character olaf = Character('Olaf', [Item('Schwert', 20), Item('Bogen', 10)],
      [Item('Miraculix', 30)]);

  //X TODO: Kämpfe bis robert Olaf besiegt hat (While-Schleife)

  while ((olaf._health > 0) & (robert._health > 0)) {
    robert.fight(olaf);
  }

  //X TODO: Nach dem Kampf schau nach ob deine Gesundheit unter 20 ist und nimm einen Trank
  if ((robert._health <= 0) & (olaf._health > 0)) {
    print('Olaf hat gewonnen und hat $olaf, Robert hat $robert');
  } else if ((robert._health > 0) & (olaf._health <= 0)) {
    print('Robert hat gewonnen und hat $robert, Olaf hat $olaf');
  } else {
    print(
        'Gleichstand, beide haben verloren. Robert hat $robert und Olaf hat $olaf');
  }
}

class Character {
  // TODO: Wenn Gegner besiegt füge Trank hinzu
  void fight(Character enemy) {
    // if no health not able to fight
    if (_health < 20) {
      takeElixir(this);
    }
    if (enemy._health < 20) {
      takeElixir(enemy);
    }
    if (_health <= 0) return;
    // if enemy has no health get his items and stop fighting
    if (enemy._health <= 0) {
      receiveItem(enemy);
      enemy.looseItems();
      _elixirs.add(Item('Powerpilz', 20));
      return;
    }
    enemy.calculateDamage(this);
    if (enemy._health > 0) {
      calculateDamage(enemy);
    } else {
      receiveItem(enemy);
      enemy.looseItems();
    }
  }

  //X TODO: Füge Methode hinzu zum Heiltrank nehmen.

  void takeElixir(Character enemy) {
    _health = _health + _healing;
    _elixirs = [];
  }

  void receiveItem(Character enemy) {
    _weapons.addAll(enemy._weapons);
    _elixirs.addAll(enemy._elixirs);
  }

  void looseItems() {
    _weapons = [];
    _elixirs = [];
  }

  void calculateDamage(Character enemy) {
    _health = _health - enemy._damage;
  }

  Character(this._name, this._weapons, this._elixirs);

  final String _name;
  int _health = 100;
  int get _damage {
    int totalDamage = 0;
    for (var item in _weapons) {
      totalDamage = totalDamage + item._value;
    }
    return totalDamage;
  }

  int get _healing {
    int totalHealing = 0;
    for (var item in _elixirs) {
      totalHealing = totalHealing + item._value;
    }
    return totalHealing;
  }

  List<Item> _weapons;

  List<Item> _elixirs;

  @override
  String toString() {
    // TODO: Zeige an wieviele Tränke dein Held hat
    return '$_damage Schaden und $_health Gesundheit und Heiltränke, die $_healing auffüllen können ${_elixirs.length}';
  }
}

class Item {
  Item(this._name, this._value);
  String _name;
  int _value;
}
