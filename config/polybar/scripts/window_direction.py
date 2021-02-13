#!/bin/python

import i3ipc

i3          = i3ipc.Connection()
splitv_text = ''
splith_text = ''
split_none  = ''
parent      = i3.get_tree().find_focused().parent

if parent.layout   == 'splitv' :
    print( splitv_text )
elif parent.layout == 'splith' :
    print( splith_text )
else                           :
    print( split_none  )