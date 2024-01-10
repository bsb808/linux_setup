
# Setup Sublime Text Editor on MacOS for Terminal / Command Line

Find the `subl` executable.  Something like 

```
$ ls "/Applications/Sublime Text.app/Contents/SharedSupport/bin"
subl
```

If not already there, make `/usr/local/bin`

```
sudo mkdir /usr/local/bin
```

Link to binary
```
sudo ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
```