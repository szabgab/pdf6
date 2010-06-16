class PDF;

method encode($type, $value) {
	given $type {
		when 'cr'        { return "\n"   }
		when 'null'      { return $value }
		when 'number'    { return $value }
		when 'verbatim'  { return $value }
		when 'string'    { return "($value)" }
		when 'boolean' {
			given $value {
				when any(<true false>) { return $value  }
				when 0                 { return 'false' }
				default                { return 'true'  }
			}
		}
		default { die "Invalid type '$type'" }
	};
}
