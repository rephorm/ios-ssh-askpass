ios-ssh-askpass
===============

An iOS version of ssh-askpass.

Requirements:

  * `ssh-agent` must be running
  * `SSH_AUTH_SOCK` must be set to the ssh agent's socket
  * `DISPLAY` must be set (to any value)

  * Either:

   - /usr/libexec/ssh-askpass must be linked to ios-ssh-askpass OR
   - `SSH_ASKPASS` is set to the fullpath of `ios-ssh-askpass`

  * `ssh-add` is run without a tty (or with stdin redirected to `/dev/null`)

When the above requirements are met, the passphrase is requested from the user by displaying a modal alert. If it is incorrectly entered, the user is given a second chance.

Detecting an existing ssh-agent
-------------------------------

By default, ssh-agent stores its socket files in `/tmp/ssh-XXXXXXXXXXXX/agent.YYYY` where the X's are a random alphanumeric string and YYYY is the pid of the original ssh-agent process. This process forks to allow the daemon to keep running in the background, so the ssh-agent daemon process will have a pid that is one higher. This allows one to recreate the `SSH_AUTH_SOCK` environment variable (and check that the agent is still running).
