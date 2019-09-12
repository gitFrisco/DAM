# DAM
Detach Attach Manager for tmux (remote) sessions running in the BASH shell.

source the dam.sh file into your shell to make the dam function useable:
$`source dam.sh`

## USE
The dam function interacts with your `bash` environment; the files `~/.ssh/config` and `~/.ssh/known_hosts` and the commands `ssh` and `tmux` to make your command line terminal a stateful place to be productive.

The simplest invocation is:
$`dam`
which attaches to the tmux session named *mine* on your current host. If the *mine* session does not exist it will be created, if it already exists `dam` will detach the session from any other terminal before attaching to it.

Should you want to create additional sessions (and you should) with meaningful names, simply append the session name to the `dam` command, *a la*:<br />
$`dam fubar`<br />
dam does not support multi-word session names at this time. If you can't remember what session names you had, simply hit the tab key after the `dam` command:<br />
$`dam <tab>`<br />
which gives you a shi^wboat load more than you expected... at least, if you are a regular `ssh` user with at least a few entries in your `~/.ssh/known_hosts` file, this is because `dam` also *knows* about `ssh` and will start `tmux` sessions on remote hosts.
