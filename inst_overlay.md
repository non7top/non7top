## Installation ##

To install this overlay you should first read this gentoo-wiki article [HOWTO Installing 3rd Party Ebuilds](http://gentoo-wiki.com/HOWTO_Installing_3rd_Party_Ebuilds)

To get a copy of non7top overlay tree just execute
```
svn checkout http://non7top.googlecode.com/svn/trunk/overlay non7top
```
[Browse overlay online](http://non7top.googlecode.com/svn/trunk/overlay)

## Updating ##

You can always simply update your local copy using <i>svn up</i> command. But for me I use paludis to update all of my overlays. It allows me to use one single command to update portage and overlays.
First you need to install paludis
```
emerge paludis -av
```
Then you need to run script which configures paludis based on portage config. All info can be found at paludis official page. Than you should just download [paludis repo config](http://non7top.googlecode.com/files/non7top.conf) and put it at /etc/paludis/repositories. Now just run paludis --sync