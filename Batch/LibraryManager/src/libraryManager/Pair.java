package libraryManager;
/**
 * 
 * @author Alex Cole
 *
 * Generic class that represents a pair of two different types of objects and implements Comparable with Pair object that
 * takes generic types E and T
 * @param <E>
 * extends comparable
 * @param <T>
 * extends comparable
 */
public class Pair<E extends Comparable<? super E>, T extends Comparable<? super T>> implements Comparable<Pair<E, T>> 
{	
	private E first;
	private T second;
	
	/**
	 * Constructor creates a pair with two different object types
	 * @param firstItem
	 * first object type of type E
	 * @param secondItem
	 * second object type of type T
	 */
	public Pair(E firstItem, T secondItem)
	{	
		first = firstItem;
		second = secondItem;
	}
	
	/**
	 * gets the first object type
	 * @return
	 * returns the first object type of type E
	 */
	public E getFirst()
	{	
		return first;
	}
	
	/**
	 * gets the second object type
	 * @return
	 * returns the second object type of type T
	 */
	public T getSecond()
	{	
		return second;
	}
	
	@Override
	public boolean equals(Object obj)
	{
		 if(obj == null) { return false; }
		 if(!(obj instanceof Pair)) { return false; }
		 
		 Pair<?, ?> other = (Pair<?, ?>) obj;
		 return this.getFirst().equals(other.getFirst()) && this.getSecond().equals(other.getSecond());
	}
	
	@Override
	public int hashCode() 
	{
		return (first == null ? 0 : first.hashCode()) ^ (second == null ? 0 : second.hashCode());
	}
	
	/**
	 * Compares two pairs to see if they are the same or different by looking at the
	 * first object type first and the second object type is the first is the same
	 * @param
	 * takes another pair for comparison
	 * @returns
	 * returns an integer that indicates if the pairs are the same(0), ascending(negative), or descending(positive)
	 */
	@Override
	public int compareTo(Pair<E, T> anotherPair) 
	{	
		//gets result of comparison of the first object types in each pair
		int firstResult = this.getFirst().compareTo(anotherPair.getFirst());
		
		//if the first object types of each pair are equal, returns the result of comparisons of the
		//second object type in each pair
		if (firstResult == 0)
		{	
			return this.getSecond().compareTo(anotherPair.getSecond());
		}
		
		return firstResult;
	}
	
	/**
	 * String representation of a Pair
	 * @return
	 * returns a string representation of a Pair in the form of [E, T]
	 */
	@Override
	public String toString()
	{
		return "[" + first.toString() + ", " + second.toString() + "]";
	}
}
