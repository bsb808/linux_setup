After installing QT, when I open an existing project or create a new project, it give me an error that says something to the effect of "no valid kits" when it tries to configure the project.  This is a showstopper.

To fixe it you can go to the Projects part of QT where you define the kits.  This will give you an "Options" window when a "Build & Run" sedtion.  A valid kit must have a compiler, a debugger and a valid Qt Version (it can't be none).

To setup the compiler, I just chose the default GCC.

To setup the debugger, again I chose the default associated with GCC.

To setup the Qt Version, I had to go to the "Qt Versions" tab and then add a Qt Version by pointing it to qmake in the /usr/bin directory.  Then back to the "Kits" tab where I changed the Qt Version from None to the new Qt Version.

