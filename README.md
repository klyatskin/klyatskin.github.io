Upcoming Events: iOS Take-home Assignment
Summary
Your assignment is to build an MVP of an app called “Upcoming Events”. In the app, users will see their upcoming
Facebook events, sectioned by start date and listed in chronological order. The app will also identify conflicts between
events.
Getting Started
Inside the zip file attached in your email, you'll find a mock.json file which contains the input for this assignment. It
contains events that each have a title, start date, and end date.
An example event showing date format:
{
"title": "Football Game",
"start": "November 3, 2018 6:00 PM",
"end": "November 3, 2018 10:00 PM"
}
You will need to write code to read in this data and convert it to a form consumable by your view controller. Note that
the events in the input file are not sorted. You can assume that events occur in your local timezone (i.e., you may
ignore time zones for this assignment).
UI Requirements:
● The upcoming events are displayed (title, start time, end time).
● The events are displayed in chronological order.
● The events are grouped by date
● There is some indication that an event has a conflict.
To accomplish this, you will need to write a small algorithm to find events that overlap each other. Note that an event
ending at the same time the next event starts is not considered conflicting.
Coding Requirements:
● Performant algorithm (It must be better than O(n²))
● Clear separation of concerns, good software architecture
Comments with:
● Brief descriptions of the algorithm
● Trade-offs or assumptions you made in your design
● Runtime complexity analysis
Submission
To submit your work, zip up everything in your project and send it to your recruiter in an email. Make sure the solution
code you send back to us compiles on the latest version of Xcode without any additional steps, like downloading
cocoapods or updating any dependencies.
Tips & FAQs
● You may solve this using Objective-C, Swift, or a mixture of both. Use whatever language you're comfortable in —
no extra points given for one language over another. :)
● You may assume that no events will start and end on different days.
● You are welcome to use any third party libraries. You should not need any extra libraries, but we won't penalize
you for using one.



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
 
