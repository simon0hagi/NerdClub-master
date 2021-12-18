import 'Character.dart';
import 'Item.dart';

void main(List<String> arguments) {
  Character robert = Character('Robert', [Item('Axt', 15)], [Item('Herzcontainer', 100)], Attitude.evil);
  Character olaf = Character('Olaf', [Item('Schwert', 20), Item('Bogen', 10)] /*[Item('Miraculix', 20)]*/);

  int i = 1;

  while (!olaf.defeated && !robert.defeated) {
    robert.fight(olaf);
    print('Runde: $i');
    print(olaf);
    print(robert);
    print('******************');
    i++;
  }
}
