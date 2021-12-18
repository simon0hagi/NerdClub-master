void main(List<String> arguments) {
  Character robert =
      Character('Robert', [Item('Axt', 15)], [Item('Herzcontainer', 100)]);
  Character olaf = Character(
    'Olaf',
    [Item('Schwert', 20), Item('Bogen', 10)], /*[Item('Miraculix', 20)]*/
  );

  //X TODO: Kämpfe bis robert Olaf besiegt hat (While-Schleife)

  int n = 1;

  while (!olaf.defeated && !robert.defeated) {
    robert.fight(olaf);
    print('Runde: $n');
    print(olaf);
    print(robert);
    print('******************');
    n++;
  }

  //X TODO: Nach dem Kampf schau nach ob deine Gesundheit unter 20 ist und nimm einen Trank
  if (!robert.defeated && !olaf.defeated) {
    print('Olaf hat gewonnen und hat $olaf, Robert hat $robert');
  } else if (!robert.defeated && (olaf._health <= 0)) {
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
      drinkElixir();
    }
    if (enemy._health < 20) {
      enemy.drinkElixir();
    }
    if (_health <= 0) return;
    // if enemy has no health get his items and stop fighting
    if (enemy.defeated) {
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

  void drinkElixir() {
    if (_elixirs.isEmpty || _health > 20) {
      return;
    }
    _health = _health + _elixirs.last._value;
    _elixirs.removeLast();
    print('$_name trinkt einen Heiltrank');
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

  Character(this._name, this._weapons, [this._elixirs = const []]);

  final String _name;
  int _health = 100;
  int get _damage {
    int totalDamage = 0;
    for (var item in _weapons) {
      totalDamage = totalDamage + item._value;
    }
    return totalDamage;
  }

  bool get defeated {
    if (_health <= 0) {
      return true;
    } else {
      return false;
    }
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
