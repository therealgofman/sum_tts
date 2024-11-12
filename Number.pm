package Number;

use strict;

my %diw = (
    0 => {
        0  => { 0 => "zero",        1 => 1},
        1  => { 0 => "",            1 => 2},
        2  => { 0 => "",            1 => 3},
        3  => { 0 => "digits_3_0",  1 => 0},
        4  => { 0 => "digits_4_0",  1 => 0},
        5  => { 0 => "digits_5_0",  1 => 1},
        6  => { 0 => "digits_6_0",  1 => 1},
        7  => { 0 => "digits_7_0",  1 => 1},
        8  => { 0 => "digits_8_0",  1 => 1},
        9  => { 0 => "digits_9_0",  1 => 1},
        10 => { 0 => "tens_1",      1 => 1},
        11 => { 0 => "nadtsatye_1", 1 => 1},
        12 => { 0 => "nadtsatye_2", 1 => 1},
        13 => { 0 => "nadtsatye_3", 1 => 1},
        14 => { 0 => "nadtsatye_4", 1 => 1},
        15 => { 0 => "nadtsatye_5", 1 => 1},
        16 => { 0 => "nadtsatye_6", 1 => 1},
        17 => { 0 => "nadtsatye_7", 1 => 1},
        18 => { 0 => "nadtsatye_8", 1 => 1},
        19 => { 0 => "nadtsatye_9", 1 => 1},
    },
    1 => {
        2  => { 0 => "tens_2",     1 => 1},
        3  => { 0 => "tens_3",     1 => 1},
        4  => { 0 => "tens_4",     1 => 1},
        5  => { 0 => "tens_5",     1 => 1},
        6  => { 0 => "tens_6",     1 => 1},
        7  => { 0 => "tens_7",     1 => 1},
        8  => { 0 => "tens_8",     1 => 1},
        9  => { 0 => "tens_9",     1 => 1},
    },
    2 => {
        1  => { 0 => "hundreds_1", 1 => 1},
        2  => { 0 => "hundreds_2", 1 => 1},
        3  => { 0 => "hundreds_3", 1 => 1},
        4  => { 0 => "hundreds_4", 1 => 1},
        5  => { 0 => "hundreds_5", 1 => 1},
        6  => { 0 => "hundreds_6", 1 => 1},
        7  => { 0 => "hundreds_7", 1 => 1},
        8  => { 0 => "hundreds_8", 1 => 1},
        9  => { 0 => "hundreds_9", 1 => 1}
    }
);

my %nom = (
    0  =>  {0 => "form_0_b", 1 => "form_0_c", 2 => "digits_1_1 form_0_a", 3 => "digits_2_1 form_0_b"},
    1  =>  {0 => "form_1_b", 1 => "form_1_c", 2 => "digits_1_0 form_1_a", 3 => "digits_2_0 form_1_b"},
    2  =>  {0 => "form_2_b", 1 => "form_2_c", 2 => "digits_1_1 form_2_a", 3 => "digits_2_1 form_2_b"},
    3  =>  {0 => "form_3_b", 1 => "form_3_c", 2 => "digits_1_0 form_3_a", 3 => "digits_2_0 form_3_b"},
    4  =>  {0 => "form_4_b", 1 => "form_4_c", 2 => "digits_1_0 form_4_a", 3 => "digits_2_0 form_4_b"},
    5  =>  {0 => "form_5_b", 1 => "form_5_c", 2 => "digits_1_0 form_5_a", 3 => "digits_2_0 form_5_b"}
);

my $out_rub;

sub in_words {
    my ($sum, $currency) = @_;
    my ($retval, $i, $sum_rub, $sum_kop);

    $retval = "";
    $out_rub = ($sum >= 1) ? 1 : 0;
    $sum_rub = sprintf("%0.0f", $sum);
    $sum_rub-- if (($sum_rub - $sum) > 0);
    $sum_kop = sprintf("%0.2f",($sum - $sum_rub))*100;

    my $kop = get_string($sum_kop, 0);

    for ($i=1; $i<6 && $sum_rub >= 1; $i++) {
        my $sum_tmp  = $sum_rub/1000;
        my $sum_part = sprintf("%0.3f", $sum_tmp - int($sum_tmp))*1000;
        $sum_rub = sprintf("%0.0f",$sum_tmp);

        $sum_rub-- if ($sum_rub - $sum_tmp > 0);
        $retval = get_string($sum_part, $i)." ".$retval;
    }
    if ($currency) {
		$retval .= "$diw{0}{0}{0} form_1_c" if ($out_rub == 0);
		$retval .= " ".$kop;
    } else {
		$retval =~ s/form_1_.*//g;
    }
    $retval =~ s/\s+/ /g;
    return $retval;
}

sub get_string {
    my ($sum, $nominal) = @_;
    my ($retval, $nom) = ('', -1);

    if (($nominal == 0 && $sum < 100) || ($nominal > 0 && $nominal < 6 && $sum < 1000)) {
        my $s2 = int($sum/100);
        if ($s2 > 0) {
            $retval .= " ".$diw{2}{$s2}{0};
            $nom = $diw{2}{$s2}{1};
        }
        my $sx = sprintf("%0.0f", $sum - $s2*100);
        $sx-- if ($sx - ($sum - $s2*100) > 0);

        if (($sx<20 && $sx>0) || ($sx == 0 && $nominal == 0)) {
            $retval .= " ".$diw{0}{$sx}{0};
            $nom = $diw{0}{$sx}{1};
        } else {
            my $s1 = sprintf("%0.0f",$sx/10);
            $s1-- if (($s1 - $sx/10) > 0);
            my $s0 = int($sum - $s2*100 - $s1*10 + 0.5);
            if ($s1 > 0) {
                $retval .= " ".$diw{1}{$s1}{0};
                $nom = $diw{1}{$s1}{1};
            }
            if ($s0 > 0) {
                $retval .= " ".$diw{0}{$s0}{0};
                $nom = $diw{0}{$s0}{1};
            }
        }
    }
    if ($nom >= 0) {
		$retval .= " ".$nom{$nominal}{$nom};
		$out_rub = 1 if ($nominal == 1);
    }
    $retval =~ s/^\s*//g;
    $retval =~ s/\s*$//g;

    return $retval;
}

1;
__END__
