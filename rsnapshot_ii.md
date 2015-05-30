# Introduction #

Small rsnapshot wrapper which allows to run rsnapshot at irregular or any random interval, makeing rotation depend only on run count.


# Details #

I've been using rsnapshot for qiute a long already and I liked its simple and straightforward way of making the backups. But there were two thing which I was missing from it:

  * backups with irregular intervals. sometimes I need to take 3 backups in a row with 5 minutes interval, and other times I only need this backup once a month.
  * missed backups. what should I do if I missed monthly and only notice it a week ago, the rotation gets a bit messed up.

And eventually I wrote a script which resolves these two issues and which became an ultimate solution for me.

Link to the script: _https://non7top.googlecode.com/svn/trunk/scripts/rsnapshot/rsnapshot\_ii_

# How it works #
Ths script operation is based only on run count, the dates in crontab or interval length make no difference. It doesn't matter how often or seldom you run the script. Interval names also make no difference.

# Example #
Say you have following intervals in your config:
```
interval        weekly  8
interval        monthly 6
interval        yearly  4
```

And this entry in crontab:
```
15 05 * * 6             /usr/local/bin/rsnapshot_ii /etc/rsnapshot.conf
```

When invoked the script will run rsnapshot weekly 8 times in a row. On 8th run it will run rsnapshot monthly so that very first weekly will become first monthly, the counter will be reset at this point and next eight runs will be weekly again, on 16th run second monthly will be executed and so on. First yearly will be run after 8\*6 runs of the script.

Run count is stored in file `$snapshot_root/.$interval.count`

## Usage ##
the script expects full path to a config file as first parameter. Config is supposed to have interval and snapshot\_root specification, also sync\_first 1 is required.