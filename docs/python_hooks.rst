******
Events
******


The problem
==================
Often I need write code that reacts to events in a larger system.  Python does not provide a standardized way to declare 

.. Hooks do not provide service to other parts of the system.


Available Solution
==================

using python set()
------------------

An event system is basically a set of functions per event.  So the most basic implementation is making every event a python set and calling every event-handler it contains when it fieres::

    class Event(set):
        def __call__(self, *args, **kwargs):
            return [func(*args, **kwargs) for func in self]

Usage::

    MAIL_SENT = Event()

    def logger(message):
        print('Hey, an email just was sent! Here is the message: ' + message)

    MAIL_SENT.add(logger)

    MAIL_SENT('Dear Jon, ...')


Attributes:

* Kiss


py-notify
---------

Attributes:

* License: LGPL
* Source Code: http://gna.org/svn/?group=py-notify
* Documentation: http://download.gna.org/py-notify/reference/index.html


pydispatcher
------------


* Homepage: http://pydispatcher.sourceforge.net/

.. https://pypi.python.org/pypi/axel



