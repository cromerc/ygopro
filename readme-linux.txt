YGOPRO 1.033.D
============================================================
Installation
============================================================
=========================
Fedora 24 64-bit
Linux Mint 18.1 64-bit
=========================
Only 64-bit is supported.
-Extract the archive
-Open a terminal and run the following commands. You only need to do this once.
$ sudo apt-get install libevent-pthreads-2.0.5
$ sudo apt-get install libopenal1
$ sudo apt-get install libsfml-audio2.3v5
$ sudo apt-get install libgit2-24
$ sudo apt-get install libcurl3

-Start ygopro:
$ ./ygopro
Or double click on ygopro

=========================
Other Linux distributions
=========================
The following libraries are needed. You are on your own!
lua5.2
freetype2
libevent
libcurl
libgit2

-Start ygopro:
$ ./ygopro
Or double click on ygopro

If it doesn't start, use the following command the check what libraries are misssing.
$ ldd ygopro

=========================
Auto update
=========================
If the auto-update doesn't work, you can do it manually.
- Open a new terminal
- Navigate to your ygopro folder (for example: cd ~/Desktop/ygopro-1.033.D-Percy)
- cd expansions/live2017
- type: $ git pull
- cd ../expansions/liveanime
- type: $ git pull

