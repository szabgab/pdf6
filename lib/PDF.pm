class PDF;

method encode($type, $value) {
	given $type {
		when 'cr'        { return "\n"       }
		when 'null'      { return $value     }
		when 'number'    { return $value     }
		when 'verbatim'  { return $value     }
		when 'name'      { return "/$value"  }
		when 'string'    { return "($value)" }
		when 'boolean' {
			given $value {
				when any(<true false>) { return $value  }
				when 0                 { return 'false' }
				default                { return 'true'  }
			}
		}

		when 'array' {
			my $s = '[';
			#say $value.perl;
			#say self.encode('name', 'any');
			$s ~= join(" ", $value.list.map(-> $x { self.encode( $x[0], $x[1] ) } ));
			#say $value.list.map(-> $x { $x[0]  } );
			# (1,2,3).map(-> $x, { say $x } );
			$s ~= "]";
			#say $s;
			return $s;
		}
		default { die "Invalid type '$type'" }
	};
}
