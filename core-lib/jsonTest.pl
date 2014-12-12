#!/usr/bin/perl

use v5.14;
use JSON::PP;

my $json_str = "{\"location\":{\"latitude\":39.991843,\"longitude\":116.476686,\"timestamp\":1418378319732,\"accuracy\":61.40214},\"timestamp\":1418378286722}";


my $hash_ref= decode_json $json_str;

say $$hash_ref{'timestamp'};
my $loc_ref=$$hash_ref{'location'};

say $$loc_ref{'latitude'};
say $$loc_ref{'longitude'};
say $$loc_ref{'timestamp'};
say $$loc_ref{'accuracy'};
