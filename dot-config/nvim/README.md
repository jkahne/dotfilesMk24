

## config vs init

`config` runs when the plugin is loaded and tries to do smart things with opts by inspecting the plugin. `init` just runs the function during startup. `init` is "more compatible" with older plugins that aren't super well integrated with lazy's practices or are written in vimscript.

There's a comment in an example in the lazy docs that says:

>> `init` is called during startup. Configuration for vim plugins typically should be set in an init function

So things writting in vimscript tend to use init to configure them.
