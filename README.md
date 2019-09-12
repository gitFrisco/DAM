# DAM
Detach Attach Manager for tmux (remote via `ssh`) sessions running in the BASH shell.

source the dam.sh file into your shell to make the dam function useable:
$`source dam.sh`

## USE
The dam function interacts with your `bash` environment; the files `~/.ssh/config` and `~/.ssh/known_hosts` and the commands `ssh` and `tmux` to make your command line terminal a stateful place to be productive.

The simplest invocation is:<br />
$`dam`<br />
which attaches to the tmux session named *mine* on your current host. If the *mine* session does not exist it will be created, if it already exists `dam` will detach the session from any other terminal before attaching to it.

Should you want to create additional sessions (and you should) with meaningful names, simply append the session name to the `dam` command, *a la*:<br />
$`dam fubar`<br />
note, `dam` does not support multi-word session names at this time. If you can't remember what session names you had, simply hit the tab key after the `dam` command:<br />
$`dam <tab>`<br />
which gives you a shi^wboat load more than you expected... at least, if you are a regular `ssh` user with at least a few entries in your `~/.ssh/known_hosts` file, this is because `dam` also *knows* about `ssh` and will start `tmux` sessions on remote hosts. Since were on the topic of remote hosts; how do you use `dam` to connect to a remote host??? well, I am glad you asked. Any argument to `dam` that contains a forward slash (or solidus, for you UTF-8 nomenclature geeks) will have the pre-slash portion treated as a hostname, including your current host environment. Even an argument which is a lone slash works to connect to you local tmux session via ssh (assuming your localhost is running the sshd service), I am not sure there is much use for that, but there it is...<br />
$`dam /`<br />
or<br />
$`dam somehost.example.com/`<br />
you can still attach to distinct sessions on the remote host by postpending the session name, as in<br />
$`dam somehost.example.com/dev`

## EPILOGUE
Thats mostly it, the real convenience starts when you load your `ssh-agent` with an identity key and you can then `<tab>` complete your way to a host/session, because hey, who wants to memorize and type all that every time you need to connect?!?
