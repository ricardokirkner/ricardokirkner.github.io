.. title: configglue 0.11 released
.. slug: configglue-011-released
.. date: 2011/06/23 18:21:49
.. tags: 
.. link: 
.. description: 


A much awaited configglue release!
==================================

This release (0.11) brings configglue another step closer to the much
awaited 1.0 milestone. 

It includes two incredible features:

**Environment variables support**

Environment variables are now supported in two flavours

*During command-line integration*

If an environment variable of the form CONFIGGLUE_FOO_BAR is defined, it will
be used to override the configuration value for option **foo** in section
**bar**, according to the following precedence rules
::

    1. Explicitly defined via command-line (i.e, --section_option=value)
    2. Implicitly defined via environment variable (i.e, CONFIGGLUE_SECTION_OPTION)
    3. Explicitly defined via configuration files
    4. Implicitly defined via schema defaults

.. raw:: html

   <br />

*As placeholders in configuration files*

In the configuration files, if an option has a value such as $FOO or ${FOO}
it will be interpolated using the FOO environment variable, or if that variable
is not defined, it will fallback to the default value for that option.

**Base class for writing configglue-enabled applications**

By inheriting from **configglue.app.App**, your application will now
automatically

*Read configuration files from standard locations*

The configglue-enabled app will automatically follow the XDG standards for
looking up configuration files. For example, if your application is named
'''myapp''', the following locations will be searched for configuration values
::

    1. /etc/xdg/myapp/myapp.cfg
    2. /home/user/.config/myapp/myapp.cfg
    3. ./local.cfg

*Support plugins for extending your application*

The class **configglue.app.Plugin** will allow you to write plugins for your
application so that each plugin can have it's own configglue-based configuration.

Each plugin registered with the application will have it's own schema and
configuration files, which will be included during validation. If the plugin
is named '''myplugin''', the following additional locations will be searched
for configuration values
::

    1. /etc/xdg/myapp/myplugin.cfg
    2. /home/user/.config/myapp/myplugin.cfg

Plugins need to be registered with the manually for the time being. For doing
so, just call **App.plugins.register**, like

.. code-block:: python

    class FooSchema(Schema):
        bar = IntOption()

    class Foo(Plugin):
        enabled = True
        schema = FooSchema

    myapp = App(name='myapp')
    myapp.plugins.register(Foo)

.. raw:: html

   <br />

This example will register a **Foo** plugin which will be enabled by default.

Plugins can be enabled/disabled on demand, by calling the respective method, like

.. code-block:: python

   >>> myapp.plugins.enable(Foo)
   >>> print myapp.plugins.enabled
   [<class 'Foo'>]

   >>> myapp.plugins.disable(Foo)
   >>> print myapp.plugins.enabled
   []

.. raw:: html

   <br />

The list of available plugins can be retrieved like

.. code-block:: python

    >>> print myapp.plugins.available
    [<class 'Foo'>]

.. raw:: html

   <br />

**Closing remarks**

Documentation is still missing for this release, but I hope that this short
introduction will raise your interest enough to check out the code and start
using it!

Questions will as usual always be answered on #configglue (on freenode).

Happy hacking!

.. _XDG: http://www.freedesktop.org/wiki/Specifications/basedir-spec
