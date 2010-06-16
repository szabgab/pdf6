class PDF;

method encode($type, $value) {
	given $type {
		when 'null' { return $value }
		default { die "Invalid type '$type'" }
	};
}