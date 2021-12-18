import 'Item.dart';

class Character {
  void fight(Character enemy) {
    int _state = 1;

    while (_state != 0) {
      //wir kämpfen bis _state=0 ist
      switch (_state) {
        case 1: //Lebt der Angreifer noch?
          if (defeated) {
            _state = 0;
          } else {
            _state++;
          }
          break;
        case 2: //Lebt der Gegner noch?
          if (enemy.defeated) {
            _state = 0;
          } else {
            _state++;
          }
          break;
        case 3:
          enemy.calculateDamage(this);
          if (enemy.defeated) {
            _state = 31;
          } else {
            _state = 32;
          }
          break;
        case 31: //enemy defeated
          receiveItem(enemy);
          enemy.looseItems();
          drinkElixir();
          _elixirs.add(Item('Superpilz', 50));
          _state = 0;
          break;

        case 32:
          calculateDamage(enemy);
          if (defeated) {
            _state = 321;
          } else {
            _state = 322;
          }
          break;
        case 321: //enemy defeated us gets items and drinks an elixir
          enemy.receiveItem(this);
          looseItems();
          enemy.drinkElixir();
          enemy._elixirs.add(Item('Superpilz', 50));
          _state = 0;
          break;
        case 322:
          enemy.drinkElixir();
          drinkElixir();
          _state = 0;
          break;
        default:
          print('unknown state $_state');
          _state = 0;
          enemy._health = 0;
          _health = 0;
          break;
      }
    }
  }

  Attitude _attitude = Attitude.good;

  void drinkElixir() {
    if (_elixirs.isEmpty || _health > 20) {
      return;
    }
    _health = _health + _elixirs.last.value;
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

  Character(this._name, this._weapons, [this._elixirs = const [], this._attitude = Attitude.good]);

  final String _name;
  int _health = 100;
  int get _damage {
    int totalDamage = 0;
    for (var item in _weapons) {
      totalDamage = totalDamage + item.value;
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
      totalHealing = totalHealing + item.value;
    }
    return totalHealing;
  }

  List<Item> _weapons;

  List<Item> _elixirs;

  @override
  String toString() {
    switch (_attitude) {
      case Attitude.good:
        return 'Der Held $_name hat $_damage Schaden und $_health Gesundheit, ${_elixirs.length} Heiltränke, ($_healing)';
      case Attitude.evil:
        return 'Der Bösewicht $_name hat $_damage Schaden und $_health Gesundheit, ${_elixirs.length} Heiltränke, ($_healing)';
    }
  }
}

enum Attitude { evil, good }
