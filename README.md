syncthing Cookbook
================








Backup and restore your gmail account at will.

This cookbook set up gmvault to allow you to backup your gmail account easily.

Requirements
------------
#### packages
- `python` - gmvault needs python to run.
- `users` - gmvault needs users to create all users that will be backed up.

Attributes
----------
TODO: List your cookbook attributes here.

e.g.
#### gmvault::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['gmvault']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### gmvault::default
Install gmvault on the node. Just include `gmvault` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[gmvault]"
  ]
}
```

#### gmvault::cron_users
Include `gmvault::cron_users` in your node's `run_list` to have it run
automatically every day. It will search for users in the databag users that are
part of the group "gmvault" and have an email address.

You will need to do the first run manually to complete the authentication.

For each user:
```json
$ gmvault user@email.tld -d /path/to/email_dir
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Dorian Jaminais
