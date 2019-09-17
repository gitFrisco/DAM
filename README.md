# DAM
Detach Attach Manager for tmux (local and remote) sessions, with autocompletion, running in the BASH shell.

## PROLOGUE (Thank Euripides for Deus ex machina)

source the dam.sh file into your shell to make the dam function useable:<br />
$`source dam.sh`

## USE
The dam function interacts with your `bash`<sup>[1](#bash)</sup> environment; the files `~/.ssh/config`<sup>[2](#ssh_config)</sup> and `~/.ssh/known_hosts`<sup>[3](#known_hosts)</sup> along with the commands `ssh`<sup>[4](#ssh)</sup> and `tmux`<sup>[5](#tmux)</sup> to make your command line terminal a stateful place to be productive.

The simplest invocation is:<br />
$`dam`<br />
which attaches to the tmux session named *mine* on your current host. If the *mine* session does not exist it will be created, if it already exists `dam` will detach the session from any other terminal before attaching to it.

Should you want to create additional sessions (and you should) with meaningful names, simply append the session name to the `dam` command, *a la*:<br />
$`dam base`<br />
note, `dam` does not support multi-word session names at this time. If you can't remember what session names you had, simply hit the tab key after the `dam` command:<br />
$`dam <tab>`<br />
which gives you a shi^wboat load more than you expected... at least, if you are a regular `ssh`<sup>[4](#ssh)</sup> user with at least a few entries in your `~/.ssh/known_hosts`<sup>[3](#known_hosts)</sup> file, this is because `dam` also *knows* about `ssh`<sup>[4](#ssh)</sup> and will create / connect to `tmux`<sup>[5](#tmux)</sup> sessions on remote hosts. Since were on the topic of remote hosts; how do you use `dam` to connect to a remote host??? well, I am glad you asked. Any argument to `dam` that contains a forward slash (or solidus, for you UTF-8 nomenclature geeks) will have the pre-slash portion treated as a hostname, including your current host environment. Even an argument which is a lone slash works to connect to you local tmux session via ssh (assuming your localhost is running the sshd<sup>[6](#sshd)</sup> service), I am not sure there is much use for that, but there it is...<br />
$`dam /`<br />
or, more likely, something similar to<br />
$`dam somehost.example.com/`<br />
you can still attach to distinct sessions on the remote host by postpending the session name, as in<br />
$`dam somehost.example.com/base`<br />
*NB* completing remote session names requires an `ssh`<sup>[4](#ssh)</sup> connection, which can be annoying unless you have identity keys setup.

## EPILOGUE
Thats mostly it, the real convenience starts when you load your `ssh-agent`<sup>[7](#ssh-agent)</sup> with an identity key and you can then `<tab>` complete your way to a host/session, because hey, who wants to memorize and type all that every time you need to connect?!?

<a name="bash">1</a>: https://linux.die.net/man/1/bash<br />
<a name="ssh_config">2</a>: https://man.openbsd.org/ssh_config<br />
<a name="known_hosts">3</a>: https://man.openbsd.org/sshd#SSH_KNOWN_HOSTS_FILE_FORMAT<br />
<a name="ssh">4</a>: https://man.openbsd.org/ssh<br />
<a name="tmux">5</a>: https://man.openbsd.org/tmux<br />
<a name="sshd">6</a>: https://man.openbsd.org/sshd<br />
<a name="ssh-agent">7</a>: https://man.openbsd.org/ssh-agent<br />
