<?php
/**
 * PHP Library to works with validation mask in PHP.
 *
 *
 * By: Rafael Silva - (Cpyleft) Tue Nov 10 11:56:41 BRST 2015
 */

/**
 * The valids characters
 * 		=> *  		-> Alpha A-Z a-z 0 1 2 3 4 5 6 7 8 9 
 * 		=> #  		-> 0 1 2 3 4 5 6 7 8 9 10
 * 		=> $  		-> A Z a z
 * 		=> -$ 		-> A Z
 * 		=> +$ 		-> a z 
 *
 * 		ex:  CPF:: ###.###.###-##
 */
if (!function_exists('mask2regex')) {
	function mask2regex($mask) {
		$regex = $mask;

		// replace all the # with [0-9] numbers
		$expressions = array(
			'\#'			=> '[0-9]',
			'\-\$' 			=> '[A-Z]',
			'\+\$' 			=> '[a-z]',
			'\*'			=> '[A-Za-z0-9]',
			'\$'			=>  '[A-Za-z]'
		);

		// replace everything else with scape
		$scapped = '';
		foreach (str_split($regex) as $str) {
			if (strpos(' .\+*?[^]$(){}=!<>|:-', $str)) {
				$scapped .= '\\' . $str;
			}	
			else $scapped .= $str;
		}
		$regex = $scapped; 

		foreach ($expressions as $expression => $regex_entity) {
			$regex = preg_replace(sprintf('/%s/', $expression), $regex_entity, $regex);
		}

		echo "$regex\n";
		// that's it. 
		return $regex;
	}
}

/**
 * function to validate the user input based on the mask, return true
 * if the string matches with the string
 * 
 * Ex: is_valid('###.###.###-##', 123.123.123-32)  => return true
 * 	   is_valid('')
 */
if (!function_exists('valid_input')) {
	function is_valid($mask, $string) {
		return preg_match(sprintf('/%s/', mask2regex($mask)), $string);
	}
}
