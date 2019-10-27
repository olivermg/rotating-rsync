# rotating-rsync

A script to help you keep backups of your data.

It will use a given source directory and keep a configured amount of 
historical copies of the data.

Running
```bash
rotating-rsync.sh /path/to/my/data bak 1 2 3
```
will for example run the following rsyncs:

1. `/path/to/my/bak2` -> `/path/to/my/bak3`
2. `/path/to/my/bak1` -> `/path/to/my/bak2`
3. `/path/to/my/data` -> `/path/to/my/bak1`

This script is thus meant to be called in desired intervals, e.g. via cron.

## Examples

For example to keep the 4 daily, 3 weekly and 2 monthly backups you could
use the crontab below:

```cron
# m   h  dom mon dow   command
  7   3   *   *  2-6   rotating-rsync.sh /path/to/data daily 1 2 3 4
  7   3   *   *   0    rotating-rsync.sh /path/to/data weekly 1 2 3
  11  4   1   *   *    rotating-rsync.sh /path/to/data monthly 1 2
```

