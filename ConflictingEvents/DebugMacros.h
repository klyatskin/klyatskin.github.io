// switch the macro to be fixing the issue of missing updates for "maxEnd" in CEBinaryNode at the stage of tree balancing
// #define DEBUG_FIXING_UNBALANCED 1



/****************
 
 General approach:
 
 - based on JSON data CEDataProvider maps the data into array of CEEvents
 - CEDataSource uses this array as a source
   - to create Interval BST where
        - the key is event start time,
        - each node also has event as a data value
        - each node has additional data maxEnd which shows the latest finish time of its subtrees nodes
   - from the tree we create a sorted array of nodes to create balanced tree
   - based upon sorted notes CEDataSource creates a dictionary adopted for UITableView to provide
 events info whith UITableView sections/rows/section titles
   - CEDataSource is registered as a table datasource through initialization in UIViewController
 - Once a table is populated, for each cell(event) shown we traverse balanced tree up to first event collisions
 - Travesal is initiated only for events with undefined collision status (a la cache)
 - Once traversal is done we mark specic event with collision status and use it to colorize the cell
 - table row cellection is disabled.
 
 The estimate of performance/memory as follows:
 - creation array of events: perfomance O(N) memory O(N)
 - creating unbalanced tree: perfomance O(N log N), at worst O(N2), memory O(N)
 - creating sorted array from a tree: perfomance O(N), memory O(N)
 - creating balanced tree from array: perfomance O(N), memory O(N)
 - collision check per event is defined by balanced tree perfomance: O(log N)
 - we do not check all events at once, we check only ones visualized in table
 
 Comments/Assumption made:
 - no muthi-treading care in CEDataProvider as it is not required in project
 - CEDataSource implemented as a singleton what could be changed/improved
 - the tree/node classes could be splitted for base and inherited classes...
 - the approach of balancing unbalanced tree could be improved to have guaranteed O(N logN) performance by creating balanced tree initially... I've used unbalanced tree to sort (what could be done by library apis instead) and my own mind exersisizing
 - code within macro DEBUG_FIXING_UNBALANCED has been left commented intentionally to show how I simplified the bug tracing I'd faced with balanced tree (the unbalanced tree which could be used for collision check also helped me to localize the issue and be sure no issues are in specific collision check code). One can play with by uncommenting line 2 in this H file...
 
 
 ***********************/
 
 
 
 
 
 
