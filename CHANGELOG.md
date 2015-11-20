Cliprompt Changelog
=====================

v0.1.2 - 2015-11-17
-------------------
- fixed buggy packaging

v0.1.1 - 2015-11-16
-------------------
- adjusted more for rspec3
- better gemspec declaration

v0.1.0 - 2014-05-10
-------------------
- fix tests for rspec 3 compliance

v0.0.6 - 2014-08-10
--------------------
- fix validation of list type to be a number

v0.0.5 - 2014-05-27
--------------------
- fix to one space after question that was 2 spaces when no default is provided
- when choices are a list, show the default in the question, in more than in the list
- clean some ruby warnings (running with --debug helps)

v0.0.4 - 2014-05-24
--------------------
- add an option `aslist` for we can decide if we want it as a list or not
- add a way to display big list, when choices are more than 5, make a list out of them

v0.0.3 - 2014-05-20
--------------------
- relax the boolean check so 1 and 0 can be used for yes and no (especially for env vars)
- added a `guess` method to have env var override question if set

v0.0.2 - 2014-05-20
--------------------
- fix case when numbers are used in choices
- added some test coverage for further evolution easiness

v0.0.1 - 2014-05-19
--------------------
- first draft
