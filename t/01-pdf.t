use v6;

use Test;
use PDF;


#my $pdf = PDF.new();
#$pdf.add_page();
#$pdf.save('out.pdf');


my @cases = (
	[Mu, 'null'],
	['anything', 'null', 'anything'], # any value

	# TODO: shouldn't this check if the given value was indeed a number?
	[Mu, 'number'],
	['value', 'number', 'value'],     # any value
	['any string', 'number', 'any string'],  # anything
	['x', 'number', 'x'],                    # anything
#	[Mu, 'number', Mu],                      # TODO eliminate warnings
	[0, 'number', 0],

	["\n",  'cr'],
	["\n",  'cr', 'abc'],             # TODO: probably should complain that a 2nd, unnecesssary param was given

	['true', 'boolean', 'true'],
	['false', 'boolean', 'false'],
	['false', 'boolean', '0'],
	['true', 'boolean', '42'],        # any other value as the 3rd item
#	['true', 'boolean', undef],       # TODO: give error or eliminate warnings

	['any string', 'verbatim', 'any string'],  # anything
	['x', 'verbatim', 'x'],                    # anything
#	[undef, 'verbatim', undef],  # TODO should give error, now fails with unknown type as the do{} fails
#	[0, 'verbatim', 0],          # TODO should work?, now fails with unknown type as the do{} fails

 
	['(any string)', 'string', 'any string'],  # anything
	['(x)', 'string', 'x'],                    # anything
#	['()', 'string', Mu],  # TODO what should happen? eliminate warnings 
	['(0)', 'string', 0],

	['/any string', 'name', 'any string'],  # anything
	['/x', 'name', 'x'],                    # anything
#	['/', 'name', Mu],  # TODO ???, eliminate warnings
	['/0', 'name', 0],
	

	['[/anything]', 'array', [ 
			['name', 'anything'],
		] 
	],
	['[/42 abc]', 'array', [ 
			['name', 42],
			['verbatim', 'abc'],
		] 
	],


);

#say @cases.perl;

	#  # TODO more complex test cases for dictionary
	#  ["<<\n/42 /text\n/abc (qwe)\n>>", 'dictionary', {
			#  42 => ['name', 'text'],
			#  abc => ['string', 'qwe'],
		#  }
	#  ],
#  
	#  # TODO more complex test cases for object
	#  ["abc 42 obj\n/qwe\nendobj", 'object', [
		#  'abc', 42, ['name', 'qwe']
		#  ]
	#  ],
#  
	#  ["abc 42 R", 'ref', ['abc', 42]],
#  
	#  ["<<\n/abc 42\n/23 /qwe\n>>\nstream\nsome data\nendstream\n", 
	#  'stream', {
			#  Data => 'some data',
			#  abc  => ['number', 42],
			#  23   => ['name', 'qwe'],
		#  }
	#  ],
#  );
#  
#  


plan @cases.elems;
#say @cases.perl;
#exit;

for @cases -> @c {
	my ($expected, $type, $value) = @c;
	my $name = $type;
#	say $expected;
#	say $name;
	if $value.defined and !($name eq any(<array dictionary object ref stream>)) {
#		say $expected;
		$name ~= ",{$value}";
	}

	#say $value.perl;
	#my $result = PDF.encode($type, $value);
	#say $result.perl;
	#say $expected.perl;
	#say $result ~~ $expected;
	#say '---';
	#is(PDF.encode($type, $value),   $expected, $name);
	ok(PDF.encode($type, $value) ~~ $expected, $name);
}

#
#my $pdf = PDF.encode();
