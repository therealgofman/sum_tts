Модуль для Asterisk, проговаривает сумму клиенту. Звуковые студийные файлы прилагаются.
За запись на студии спасибо Марине Хрусталевой.

Если в функцию in_words вторым аргументом передать undef, то функцию опускает рубли и копейки, работает только число (удобно к примеру произнести номер заявки).
Пример использования:
```
use Number;
$AGI->exec('Playback', "minus") if ($balance < 0);
$balance =~ s/-//g;
my $balance_word   = Number::in_words($balance, 1);
my @balance_digits =  split / /, $balance_word;
foreach my $digit (@balance_digits) {
	$AGI->exec('Playback', "$digit");
}
```