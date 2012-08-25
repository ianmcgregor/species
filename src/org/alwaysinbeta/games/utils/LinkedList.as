package org.alwaysinbeta.games.utils {
	/**
	 * @author ian
	 */
	public class LinkedList {
		public var first: ILinkedListItem;
		public var last: ILinkedListItem;
		
		public function remove(item : ILinkedListItem) : ILinkedListItem {
			if (null != item.next) {
				item.next.prev = item.prev;
			}
			
			if (null != item.prev) {
				item.prev.next = item.next;
			}
			
			if (item == first) {
				first = item.next;
			}
			
			if (item == last) {
				last = item.prev;
			}
			
			//	Remove references to allow garbage collection
			item.next = item.prev = null;
			return item;
		}
		
		public function insertAfter(item : ILinkedListItem, after : ILinkedListItem) : void {
			item.prev = after;
			item.next = after.next;
			
			if (after.next == null) {
				last = item;
			} else {
				after.next.prev = item;
			}
			
			after.next = item;
		}

		public function insertBefore(item : ILinkedListItem, before : ILinkedListItem) : void {
			item.prev = before.prev;
			item.next = before;

			if (before.prev == null) {
				first = item;
			} else {
				before.prev.next = item;
			}
			
			before.prev = item;
		}
	}
}
