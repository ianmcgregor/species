package org.alwaysinbeta.games.utils {
	/**
	 * @author ian
	 */
	public interface ILinkedListItem {
		function get prev(): ILinkedListItem;
		function set prev(item: ILinkedListItem): void;
		function get next(): ILinkedListItem;
		function set next(item: ILinkedListItem): void;
	}
}
