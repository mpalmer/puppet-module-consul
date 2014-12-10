Install and manage consul.


# Usage

To install an agent, go like this:

    consul::agent { "foo":
      # Should this agent be a server, or a client?
      server => true,   # or false
      # Tell the agent to join an existing cluster automagically
      join   => undef,  # or a hostname/IP address
      # What to set -bootstrap-expect to (only for server => true)
      expect => 5,
    }
