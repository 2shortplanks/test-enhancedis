use inc::Module::Install;

# Define metadata
name           'Test-EnhancedIs';
all_from       'lib/Test/EnhancedIs.pm';

requires       'Test::Builder' => 0.92;
requires       'List::Util' => 0,
requires       'Term::ANSIColor' => 0,

license 'perl';

WriteAll;
