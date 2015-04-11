# OpenStax Exchange

## Overview

OpenStax Exchange is the big data dump for learner interaction data.  It has the following high-level goals:

1. Provide mechanisms for learning platforms to submit learner interaction data
2. Provide mechanisms for machine learning tools, researchers, learning platforms, and developers to access that data
3. Maintain student anonymity as much as possible

"Learner interaction data" is factual information describing the interaction between a learner, a learning platform, learning material, and the learner's peers and instructors.  It comes in two varieties: Events and Activities.

* **Event** - An interaction that occurs at an instant in time.  There are different kinds of events and each is represented by different fields.  Events can be submitted from a learning platform's server-side or client-side code.  Events include things like
   * student 34 answered exercise 45 incorrectly at time T1
   * student 90 opened module 42 at time T2
   * student 12 moved their mouse on module 67 at time T3
   * student 60 clicked on a link with URL X at time T4
   * student 56's page looking at module 86 sent a heartbeat signal at time T5
   * instructor 87 attached a grade to student 92's work at time T6

   See Appendix 1 for an extensive brainstorming of possible events.  For internal storage in the database, these events have been collapsed into a small number of generalized events as discussed in the Model Overview.
* **Activity** - An aggregation of related Events that summarizing an interaction that occurs over a period of time.  Activities are defined by start and "last activity at" timestamps and various metadata.  Activities include things like:

   * student 22 worked exercise 42 from time T1 to T2, wrote free response Y, chose multiple-choice answer Z, which was incorrect.
   * student 76 interacted with simulation 34 from T3 to T4, and the simulation reported that the student succeeded at 80% of the simulation.
   * student 84 watched video 67 from T5 to T6
   * student 45 reviewed feedback 87, of type "hint" for exercise 23.

   Activities are not submitted directly by learning platforms.  Rather, Exchange monitors the stream of incoming Events and creates new and updates existing Activities as needed.  See Model Overview for proposed Activities.

While Exchange does have a few web views, it is largely an API-centric system.

Learning tools that use Exchange's API to write and read learner interaction data are referred to as **Platforms**.  In general, a Platform can read any data that it has written to Exchange and it can also read aggregate data that covers data written by other Platforms.  For example, a Platform can read the details for its submissions for exercise 42, but it can pull statistics on exercise 42 that cover submissions from all Platforms (e.g. the percentage of students who got exercise 42 correct).

A Platform like BigLearn will only read data either at the request of a Platform or on notification of data availability from Exchange.

Both to address privacy concerns and because our algorithms allow it, we want Exchange's data to be as anonymized as possible.  To that end, we do not store personally-identifiable information (PII) about students in Exchange.  Students (as well as other members of the learning process, see later discussion) are referred to by a random **Identifier**.  An Identifier consists of two long random hex keys, one of which provides read-only access to the identified student's data, and the other of which provides read-write access.  The read-write key is used by Platforms when communicating with Exchange; the read-only key is given from one Platform to another (e.g. from Tutor to BigLearn), so the latter Platform can read and act on the former Platform's data. Platforms should protect read-write keys like they would a password.

When a Platform wants to start submitting data for a new student, it asks Exchange to create and return a new Identifier for her.  Identifier keys are globally unique.  The Platform must then permanently store that Identifier's value so that it can communicate with Exchange about this student.  Exchange maintains a record of the Identifier and connects it to the requesting Platform, but it does not maintain any linkage between the Identifier and the Platform's student.   A Platform will accumulate many Identifiers, one for each of its students.

It is possible that two Platforms (e.g. Tutor, CNX) could submit data for the same student.  However, those Platforms would not be using the same Identifier for that student -- they'd each have requested unique Identifiers from Exchange.  To permit the eventual linking of Identifiers to one user (to improve analytics and recommendations for that student), a **Person** model is used to associate multiple Identifiers with a specific individual.  Each Identifier is connected to a Person; a Person is connected to one or more Identifiers.  When two Identifiers are linked, the Person of one of the Identifiers is chosen to continue to exist and the other dies off.  See the discussion later in this document about how this linking can be done.

Each Person also has a more public random label called an **analysis ID**.  Analysis IDs are used when reporting data to researchers and in data dumps to the machine learning algorithms (readonly and readwrite Identifier keys are explicitly not used in any data export from Exchange).  When Identifiers are linked, the associated Person that continues to exist is responsible for keeping a record of the analysis ID owned by the Person that died off during the merge.  This history will be useful for debugging and otherwise tracing the history of data.

As stated above, a learning Platform will have detailed access to all of the data it has stored in Exchange.  Human representatives of a Platform will also be granted access to manual queries of this same data.  These representatives are called **Agents**.

The goal is that once data reaches Exchange, it will be de-identified enough so that we no longer need to track the connection between that data and the IRB protocol under which it was collected.  Exchange as a de-identified data store will have a separate IRB governing its existence and access.  Exchange will keep track of which data was collected as consented and which was not, so that only consented data is reported to researchers.  However, Exchange does not keep detailed track of the IRB protocols under which data was collected.

**Researchers** in Exchange are those users marked as having read access any learner interaction data.

## Model Overview

* **Platform** - A student- and faculty-facing learning application.  Has many Identifiers for which it can read and write learner interaction data.  Has many human Agents who can read / delete data for its Identifiers.  Creation of Platforms should be a controlled process: can be done either by site admins only or by users with approval of site admins.  In the latter case, the creating user would become the first Agent manager of the Platform.

* **Agent** - A human User associated with a Platform.  Can read / delete data for Identifiers accessible by their Platform.  An Agent can be marked as a manager for a Platform, meaning that user can edit the properties of the Platform, add or remove Agents for the Platform, or make other of the Platform's Agents managers.  An example of an Agent would be someone who worked at a learning platform, including data scientists / analysts not subject to the constraints of IRB data collection.  Agents are not typically folks interacting with learning content inside of the platform (i.e. not folks teaching or taking a class).

* **Identifier** - An pair of anonymized keys for a Platform user who is involved in learner interactions.  The biggest group of Platform users with Identifiers will be the Platform's students, but we will also want to track interactions for graders (who may or may not be students) and possibly for educators as well.  There is one unique Identifier for every combination of a Platform user and a Platform (e.g. one human student using multiple learning platforms would be represented by multiple Identifiers).

* **Person** - a model used to link Identifiers together that label the same underlying human.  To maintain anonymity, a Person should never be attached to an Exchange User.

* **Activity** - bundles and summarizes a collection of Events to describe an Activity as described at the start of this document.  Is always associated with an Identifier.  While there are different kinds of activities, they share some common fields, including start and "last_activity" times, amount of time inactive, resource, an optional task.  The following list describe the Activities we plan to include:

  1. ExerciseActivity (one exercise part)
    1. Multiple choice/Short answer/Matching
    1. Free response
    1. Correctness
    1. Time spent on each part
  1. FeedbackActivity (one exercise part)
    1. Correctness
    1. Grade assigned
    1. Feedback (explanation) received
    1. Amount of time spent looking at each item
  1. ReadingActivity (one resource)
  1. PeerGradingActivity (one exercise)
    1. Grader ID
    1. Gradee ID
    1. Grade assigned
    1. Feedback given
  1. InteractiveActivity
    1. How close the user got to the interactive's goal (if present) - could be recorded at several intervals
  1. CommunicationActivity (messaging, discussion)
    1. Recipients (to, cc, bcc - text)
    1. Subject (text)
    1. Body (text)

* **Event** - Stores factual data connected to an Identifier.  Opinions about the event (e.g. in an ExerciseEvent, what one professor believes the exercise's underlying concept to be) are specifically excluded.  Such opinion data belongs in a system capable of juggling different beliefs from different users, i.e. Linkify.  There likely won't be a real "Event" base class, but rather a collection of specific Event classes for different kinds of Events.  Regardless of implementation, all events record the time the event occurred, an Identifier, the ID for a related Resource, along with a unique number describing which interaction with the Resource this event describes (e.g. we need to be able to separate Jimmy's attempt at exercise 42 today vs his retry two months from now).

  We've boiled the exhaustive list of Events down to the following generalized types:

  *Likely submitted client-side:*

  1. BrowsingEvent (unique identifier, referer)
  1. CursorEvent (mouse position, clicked?, unique id of object clicked/under the mouse, is_eye_tracking?)
  1. HeartbeatEvent - (page position)
  1. InputEvent (unique identifier of input object, unique identifier of input type/purpose, data type, text typed/generated or contents of   uploaded file, [optional file name])

  *Likely submitted server-side:*

  1. TaskEvent - number, assigner_id (the ID of the person or algorithm that assigned the task), assigner_type (is this an instructor or algorithm?), due_date (nil means optional), is_complete
  1. GradingEvent - grader_id, grader_type, grade, feedback

  A TaskEvent describes an assignment of something to someone (often a student, sometimes an instructor) by someone else (instructor, algorithm, self).  A tasks can be updated by creating a new TaskEvent with the same number. An activity that contains a task was an assignment.

* **Researcher** - A human User with read access to all data.  Faculty should never be Researchers (see later discussion about the research / education firewall).  Researchers should also not be Agents, and vice versa.

* **User** - a human user of Exchange.  Implemented in large part with connect-rails and OpenStax Accounts.  User account holders should only include site admins and those who are Agents and Researchers.  Students and faculty should likely not have accounts.  An exception would be a faculty member who has been granted Agent access.  Students should not have accounts on Exchange for two reasons: (1) we want to avoid connecting student data on Exchange to student PII (which would come with an Exchange account) and (2) we hope that we will eventually get data from non-OpenStax sources, and those students will have no need or motivation to get / maintain such an account.  A User can be flagged as a site administrator.

* **Resource** - a table which simply maps some sort of unique resource label to an ID which can be referenced from the sundry models above.  When the models above have lots and lots of records, this Resource table will help save space (see Activities and Events).  The Resource table will also help us connect events that refer to common Resources.  The label could be a URL or some Platform-specific string or integer pointing to a Platform-specific resource.  Non URL resource values (non-standard URIs) should be linked to the Platform from which they originated so that multiple Platforms can use the same label without colliding.  E.g. Tutor and CNX could both refer to resource 37299, but that resource would likely be different on the two systems.  URLs should not be linked to Platforms so that knowledge about them can transfer between Platforms.  The Resource model can also do some nice things in terms of standardizing URLs, e.g. it could maybe realize that "https://quadbase.org/questions/q35v1" and "http://quadbase.org/questions/q35v1/" are the same and store them as one combined resource.  Resources may also contain cached textual versions of the underlying resource (e.g. question or module text), though the utility of that is up for debate.  Resources include (at least) modules, exercises, assignments, interactives, topics, discussions, comments, feedback, videos, audio files, plain old web pages, other misc files (PDF, PPT, etc)
