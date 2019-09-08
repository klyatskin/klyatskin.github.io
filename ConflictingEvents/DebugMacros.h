// switch the macro to be fixing the issue of missing updates for "maxEnd" in CEBinaryNode at the stage of tree balancing
// #define DEBUG_FIXING_UNBALANCED 1



/****************
 
 General approach:
 
 - based on JSON data CEDataProvider maps the data in array CEEvents
 - CEDataSource used this array as a source
   - to create BST tree where the key is event start time,
   - each node also has event as a data valu
   - each node has additional data maxEnd which shows the latest finish time of subtrees nodes
   - from originally created tree we create a sorted array of nodes to create balanced tree
   - based upon balanced tree CEDataSource which creates a dictionary adopted for UITableView to provide
 infor about sections/rows/section titles
   - CEDataSource is registered as a table datasource through initialization in UIViewController
 - Once a table is populated, for each cell(event) shown we traverse balanced tree up to first event collisions.
 - Travesal is initiated only for events with undefined collision status (a la cache)
 - Once traversal is done we mark specic event with collision status and use it to colorize the cell
 - table row cellection is disabled.
 
 The estimate of total performance = O(N log N) memory = O (N) is as follows:
 - creation array of events: perfomance O(N) memory O(N)
 - creating unbalanced tree: perfomance O(log N), at worst O(N), memory O(N)
 - creating sorted array O(N), memory O(N)
 - creating balance tree: perfomance O(log N) memory O(N)
 - collision check per event is defined by balance tree perfomance O(log N)
 - we do not check all events but only ones visualized in table
 
 Comments/Assumption made:
 - no muthi-treading care in CEDataProvider as not used in project
 - CEDataSource implemented as a singleton what could be improved. 
 - the tree class could be splitted for base and inherited classes...
 - the approach of balancing unbalanced tree could be improoved by creating balanced tree initially... I've used unbalanced tree for sorting (what could be done by library apis) and my exersisizing
 - code with DEBUG_FIXING_UNBALANCED left commented intentionally to show how I simplified the bug tracing I'd faced with balanced tree (and unbalanced tree which could be for collision check helped me to localize the issue and be sure no issues are in collision check code). One can play with by uncommenting line 2 in this file...
 ***********************/
 
 
 
 
 
 
