/**
 * Sorts a multidimensional array based on a given index
 * 
 * @param array
 *            The multidimensional array to be sorted
 * @param index
 *            The array's index to sort by
 * @param asc
 *            1 for ascending sort, 2 for descending
 */
function sortArrayByIndex(array, index, asc){
	array = array.sort(compare);
	if (asc == 0) {
		array.reverse();
	}
	
	// Compare function for the array sort
	function compare(a, b){
		// If the indices are exactly the same, return 0
		if (a[index] === b[index]) {
			return 0;
		} else {
			// Check if string
			if (typeof a[index] == "string") {
				// If string, compare them lexographically by cheating and
				// converting them to uppercase
				return (a[index].toUpperCase() < b[index].toUpperCase() ? -1
				        : 1);
			} else {
				// If not a string, compare them by simple comparison
				return (a[index] < b[index]) ? -1 : 1;
			}
		}
	}
	
}