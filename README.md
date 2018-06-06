[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/1894/badge)](https://bestpractices.coreinfrastructure.org/projects/1894)

# HomelabOS

Your very own offline-first open-source data-center!

## Summary

A set of Ansible scripts to configure a Docker based Homelab server with all sorts of goodies.

## Goals

To make it easy for anyone to own all their data in an easy and secure way, without the need of cloud providers.

## Features

* One command depyloment
* Automated HTTPS endpoints (Coming Soon)
* Automated Backups (Coming Soon)
* Easy Restore (Coming Soon)
* Dynamic DNS Support (Coming Soon)
* Automated Apple Health Import (Coming Soon)

## Demo

![demo.gif](demo.gif)

## Included Software

* [Chronograf](https://www.influxdata.com/time-series-platform/chronograf/) - More pretty graphs. Easy data exploration
* [Convos](https://convos.by/) - Always-on IRC client (IRC bouncer)
* [Dashboard](https://github.com/causefx/Organizr) - Access all your HomelabOS services in one easy place.
* [Darksky](http://darksky.net/) - Local weather reported via [darksky-influxdb](https://github.com/ErwinSteffens/darksky-influxdb)
* Documentation - Offline, searchable documentation via [MkDocs](https://www.mkdocs.org/)
* [Emby](https://emby.media/) - Media player
* [Gitea](https://gitea.io/en-US/) - Git hosting
* [Grafana](https://grafana.com/) - Pretty graphs
* [Home Assistant](https://www.home-assistant.io/) - Home Aatomation
* [InfluxDB](https://www.influxdata.com/time-series-platform/influxdb/) - Time series data storage
* [NextCloud](https://nextcloud.com/) - Private Cloud Storage, Calendar, Contacts, LDAP, etc.
* [Pi-hole](https://pi-hole.net/) - Ad blocking
* [Sonerezh](https://www.sonerezh.bzh/) - Music streaming and library management
* [Telegraf](https://www.influxdata.com/time-series-platform/telegraf/) - Server statistics reporting
* [Terminal](georgeyord/butterfly-web-terminal) - Web based terminal access

### Coming Soon

* BitWarden - Password manager
* BulletNotes - Note taking knowledgebase with kanban and calendar functionality.
* OwnTracksRecorder - https://github.com/owntracks/recorder
* Paperless - Document management https://paperless.readthedocs.io/en/latest/setup.html#installation-configuration
* [Transmission](https://transmissionbt.com/) - BitTorrent client via [https://github.com/haugene/docker-transmission-openvpn](https://github.com/haugene/docker-transmission-openvpn)

## Requirements

A server running Ubuntu 18.04 accessible via ssh with a user that has sudo.

A domain configured with a `A` type DNS record of `*.yourdomain.com` pointed at your server's IP address.

Ports 80 and 443 punched through any firewalls and port forwarded at your server in question.

Ansible version 2.5+ installed on your computer (not the server).

## Installation

From your computer (not the server) run `ansible-playbook -i hosts homelabos.yml`.

## Contributing

Please do!

### Working locally on the documentation

Follow the [MkDocs Material Theme setup directions](https://squidfunk.github.io/mkdocs-material/getting-started/).

Then run `mkdocs serve`