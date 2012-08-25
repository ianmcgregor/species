package org.alwaysinbeta.games.utils {
	import flash.utils.Dictionary;

	/**
	 * @author ian
	 */
	public final class ObjectPool {
		
		// generic pool of object pools that handles different class types
		
		private static var _pools : Dictionary = new Dictionary();
		
		// return existing pool or create a new one
		private static function getPool(clazz : Class) : Array {
			return clazz in _pools ? _pools[clazz] : _pools[clazz] = [];
		}
		
		// get an object from the pool or create a new one of empty
		public static function get(clazz : Class) : Object {
			var pool : Array = getPool(clazz);
			if ( pool.length > 0 ) {
				return pool.pop();
			} else {
				return new clazz();
			}
		}
		
		// put it back for reuse
		public static function dispose(object : Object) : void {
			var type : Class = object.constructor as Class;
			var pool : Array = getPool(type);
			pool[pool.length] = object;
		}
		
		// pre-fill the object pool with instances
		public static function fill(clazz : Class, count: uint) : void {
			var pool : Array = getPool(clazz);
			while ( pool.length < count ) {
				pool[pool.length] = new clazz();
			}
		}
		
		// discard all the pools
		public static function empty() : void {
			_pools = new Dictionary();
		}
		
		// get the pools dict - only used to monitor pools in debug tool
		public static function get pools() : Dictionary {
			return _pools;
		}
	}
}