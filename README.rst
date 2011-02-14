===================
Basho bench samples
===================

This project contains some sample driver modules and config files for Basho bench.

cf) Benchmarking with Basho Bench http://wiki.basho.com/Benchmarking-with-Basho-Bench.html

Build
-----

Just ``make`` to build.

::

  $ make

Execute sample benchmark
------------------------

The ``basho_bench`` script is the same one at ``deps/basho_bench/basho_bench``.
Config files are under ``priv`` directory.

::

  $ ./basho_bench priv/file_write_test.config


Generate summary graph
----------------------

::

  $ make results
