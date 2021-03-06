package test_fates_mode;

# Unit tests for function: fates_mode

use Data::Dumper;
use Test::More;
use Test::Exception;

use parent qw(Test::Class);

use CLMBuildNamelist qw(setup_cmdl_fates_mode);
use CLMBuildNamelist qw(setup_logic_fates);


#-------------------------------------------------------------------------------
#
# Common test fixture for all tests:
#
#-------------------------------------------------------------------------------
sub startup : Test(startup => 4) {
  my $self = shift;
  # provide common fixture for all tests, only created once at the
  # start of the tests.

  $self->{cfg} = Build::Config->new("t/input/config_cache_clm4_5_test.xml");
  isnt($self->{cfg}, undef, (caller(0))[3] . " : config object created.");

  $self->{definition} = Build::NamelistDefinition->new("t/input/namelist_definition_clm4_5_test.xml");
  isnt($self->{definition}, undef, (caller(0))[3] . " : namelist_definition object created.");

  $self->{defaults} = Build::NamelistDefaults->new("t/input/namelist_defaults_clm4_5_test.xml",$self->{cfg});
  isnt($self->{defaults}, undef,  (caller(0))[3] . " : namelist_defaults object created.");

  $self->{physv} = config_files::clm_phys_vers->new( $self->{cfg}->get('phys') );
  isnt($self->{physv}, undef,  (caller(0))[3] . " : phys_vers object created.");

  $self->{test_files} = 0;

}

sub shutdown : Test(shutdown) {
  # cleanup the single instance test fixtures
}

sub setup : Test(setup => 1) {
  my $self = shift;
  # provide common fixture for all tests, create fresh for each test

  $self->{nl} = Build::Namelist->new();
  isnt($self->{nl}, undef, (caller(0))[3] . " : empty namelist object created.");

  $self->set_value('crop', 'off');

}

sub teardown : Test(teardown) {
  # clean up after test
}

sub set_value {
    # Set the value of a namelist option
    my ($self, $var, $value) = @_;
    my $group = $self->{definition}->get_group_name($var);
    $self->{nl}->set_variable_value($group, $var, $value);
}



#-------------------------------------------------------------------------------
#
# tests
# 
#-------------------------------------------------------------------------------

# Test 1: use_century_decomp is default with fates_mode
sub test_fates_mode__use_century_decomp : Tests {
  my $self = shift;

  my $msg = "Test that use_century_decomp is the default on fates_mode.\n";

  my $opts = { bgc => "fates" };
  my $nl_flags = { crop => "off"}; # the setup_cmdl_fates_mode code requires this logic

  # include bgc because they have mutually exclusive functionality that needs to be tested
  CLMBuildNamelist::setup_cmdl_bgc($opts, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{cfg},$self->{physv});
  CLMBuildNamelist::setup_cmdl_fates_mode($opts, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{physv});
  CLMBuildNamelist::setup_logic_fates($self->{test_files}, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{physv});

  my $group = $self->{definition}->get_group_name("use_century_decomp");
  my $result = $self->{nl}->get_variable_value($group, "use_century_decomp");
  is($result, '.true.' ) || diag($msg);
  
}

# Test 2: use_vertsoilc is default with fates_mode
sub test_fates_mode__use_vertsoilc : Tests {
    my $self = shift;

    my $msg = "Tests that use_vertsoilc is default on fates_mode.\n";

    my $opts = { bgc => "fates"};
    my $nl_flags = { crop => "off", };

    CLMBuildNamelist::setup_cmdl_bgc($opts, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{cfg},$self->{physv});
    CLMBuildNamelist::setup_cmdl_fates_mode($opts, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{physv});
    CLMBuildNamelist::setup_logic_fates($self->{test_files}, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{physv});

    my $group = $self->{definition}->get_group_name("use_vertsoilc");
    my $result = $self->{nl}->get_variable_value($group, "use_vertsoilc");
    is($result, '.true.' ) || diag($msg);
}

# Test 3: use_fates_spitfire is default with fates_mode
sub test_fates_mode__use_fates_spitfire : Tests {
    my $self = shift;

    my $msg = "Tests that use_fates_spitfire is default on fates_mode.\n";

    my $opts = { bgc => "fates"};
    my $nl_flags = { crop => "off", };

    CLMBuildNamelist::setup_cmdl_bgc($opts, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{cfg},$self->{physv});
    CLMBuildNamelist::setup_cmdl_fates_mode($opts, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{physv});
    CLMBuildNamelist::setup_logic_fates($self->{test_files}, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{physv});

    my $group = $self->{definition}->get_group_name("use_fates_spitfire");
    my $result = $self->{nl}->get_variable_value($group, "use_fates_spitfire");
    is($result, '.true.' ) || diag($msg);
}

# Test 4: use_nitrif_denitrif is not default with fates_mode
sub test_fates_mode__use_nitrif_denitrif: Tests {
    my $self = shift;

    my $msg = "Tests that us_nitrif_denitfif e i nots default on fates_mode.\n";

    my $opts = { bgc => "fates"};
    my $nl_flags = { crop => "off", };

    CLMBuildNamelist::setup_cmdl_bgc($opts, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{cfg},$self->{physv});
    CLMBuildNamelist::setup_cmdl_fates_mode($opts, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{physv});
    CLMBuildNamelist::setup_logic_fates($self->{test_files}, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{physv});

    my $group = $self->{definition}->get_group_name("use_nitrif_denitrif");
    my $result = $self->{nl}->get_variable_value($group, "use_nitrif_denitrif");
    is($result, '.false.' ) || diag($msg);
}

# Test 5: use_lch4 is not default with fates_mode
sub test_fates_mode__use_lch4: Tests {
     my $self = shift;
     
     my $msg = "Tests that use_lch4 is not default on fates_mode.\n";

     my $opts = { bgc => "fates"};
     my $nl_flags = { crop => "off", };

     CLMBuildNamelist::setup_cmdl_bgc($opts, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{cfg},$self->{physv});
     CLMBuildNamelist::setup_cmdl_fates_mode($opts, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{physv});
     CLMBuildNamelist::setup_logic_fates($self->{test_files}, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{physv});

     my $group = $self->{definition}->get_group_name("use_lch4");
     my $result = $self->{nl}->get_variable_value($group, "use_lch4");
     is($result, '.false.' ) || diag($msg);
}

# Test 6: use_fates=false will crash on fates_mode
sub test_fates_mode__use_fates_nl_contradicts_cmdl : Tests {
    my $self = shift;

    my $msg = "Tests that use_fates=false will fail on fates_mode.\n";

    my $opts = { };
    my $nl_flags = { crop => "off", use_fates => ".false.", , bgc_mode => 'fates',};

    my $group = $self->{definition}->get_group_name("use_fates");
    $self->{nl}->set_variable_value($group, "use_fates", '.false.' );

    dies_ok(sub { CLMBuildNamelist::setup_cmdl_fates_mode($opts, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl},
							$self->{physv}) }) || diag($msg);
}

# Test 7: crop=on will crash on fates_mode
sub test_fates_mode__crop_on_nl_contradicts_cmdl : Tests {
    my $self = shift;

    my $msg = "Tests that crop=on will fail on fates_mode.\n";

    my $opts = { };
    my $nl_flags = { crop => "on", bgc_mode => 'fates'};

    my $group = $self->{definition}->get_group_name("crop");
    $self->{nl}->set_variable_value($group, "crop", 'on' );

    dies_ok(sub { CLMBuildNamelist::setup_cmdl_fates_mode($opts, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl},
						   $self->{physv}) }) || diag($msg);
}

# Test 8: test that use_fates_spitfire = false generates a false
sub test_fates_mode__use_fates_spitfire_false : Tests {
    my $self = shift;

    my $msg = "Tests that use_fates_spitfire can be turned to false.\n";

    my $opts = { bgc => "fates"};
    my $nl_flags = { crop => "off", };

    my $group = $self->{definition}->get_group_name("use_fates_spitfire");
    $self->{nl}->set_variable_value($group, "use_fates_spitfire", '.false.' );

    CLMBuildNamelist::setup_cmdl_bgc($opts, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{cfg},$self->{physv});
    CLMBuildNamelist::setup_cmdl_fates_mode($opts, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{physv});
    CLMBuildNamelist::setup_logic_fates($self->{test_files}, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{physv});

    my $result = $self->{nl}->get_variable_value($group, "use_fates_spitfire");
    is($result, '.false.' ) || diag($msg);

}

# Test 9: test that use_versoilc = false generates a false
sub test_fates_mode__use_vertsoilc_false : Tests {
    my $self = shift;

    my $msg = "Tests that use_vertsoilc can be turned to false.\n";

    use CLMBuildNamelist qw(setup_cmdl_fates_mode);	
    use CLMBuildNamelist qw(setup_logic_fates);	

    my $opts = { bgc => "fates"};
    my $nl_flags = { crop => "off", };

    my $group = $self->{definition}->get_group_name("use_vertsoilc");
    $self->{nl}->set_variable_value($group, "use_vertsoilc", '.false.' );

    CLMBuildNamelist::setup_cmdl_bgc($opts, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{cfg},$self->{physv});
    CLMBuildNamelist::setup_cmdl_fates_mode($opts, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{physv});
    CLMBuildNamelist::setup_logic_fates($self->{test_files}, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{physv});

    my $result = $self->{nl}->get_variable_value($group, "use_vertsoilc");
    is($result, '.false.' ) || diag($msg);

}

# Test 10: test that use_century_decomp = false generates a false
sub test_fates_mode__use_century_decomp_false : Tests {
    my $self = shift;

    my $msg = "Tests that use_vertsoilc can be turned to false.\n";

    my $opts = { bgc => "fates"};
    my $nl_flags = { crop => "off", };

    my $group = $self->{definition}->get_group_name("use_century_decomp");
    $self->{nl}->set_variable_value($group, "use_century_decomp", '.false.' );

    CLMBuildNamelist::setup_cmdl_bgc($opts, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{cfg},$self->{physv});
    CLMBuildNamelist::setup_cmdl_fates_mode($opts, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{physv});
    CLMBuildNamelist::setup_logic_fates($self->{test_files}, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{physv});

    my $result = $self->{nl}->get_variable_value($group, "use_century_decomp");
    is($result, '.false.' ) || diag($msg);

}

# Test 11: test that use_lch4 = true generates a true
sub test_fates_mode__use_lch4_true : Tests {
    my $self = shift;

    my $msg = "Tests that use_vertsoilc can be turned to false.\n";

    my $opts = { bgc => "fates"};
    my $nl_flags = { crop => "off", };

    my $group = $self->{definition}->get_group_name("use_lch4");
    $self->{nl}->set_variable_value($group, "use_lch4", '.true.' );

    CLMBuildNamelist::setup_cmdl_bgc($opts, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{cfg},$self->{physv});
    CLMBuildNamelist::setup_cmdl_fates_mode($opts, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{physv});
    $nl_flags->{"use_fates"} = $self->{nl}->get_value("use_fates");

    CLMBuildNamelist::setup_logic_fates($self->{test_files}, $nl_flags, $self->{definition}, $self->{defaults}, $self->{nl}, $self->{physv});

    my $result = $self->{nl}->get_variable_value($group, "use_lch4");
    is($result, '.true.' ) || diag($msg);

}

1;
