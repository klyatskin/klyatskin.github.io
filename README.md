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
