# DAM
Detach Attach Manager for tmux (remote) sessions running in the BASH shell.

source the dam.sh file into your shell to make the dam function useable:<br>
$<code>source dam.sh</code>

## USE
The dam function interacts with your bash environment, the files ~/.ssh/config ~/.ssh/known_hosts and the commands ssh and tmux to make your command line terminal a stateful place to be productive.

The simplest invocation is:<br>
$<code>dam</code><br>
which attaches to the tmux session named *mine* on your current host.
