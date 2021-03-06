# Apache 2

[Apache 2](https://httpd.apache.org/) is a free web server.

It is included with HomelabOS to serve directory listings or static sites.

After enabling apache2 and running `make`, just place the files you want to
server in `{{ volumes_root }}/apache2/root/` on your server.

You can set the `apache2.subdomain` config setting to change the subdomain
from `apache2` to something else.

## Access

It is available at [https://{% if airsonic.domain %}{{ airsonic.domain }}{% else %}{{ airsonic.subdomain + "." + domain }}{% endif %}/](https://{% if airsonic.domain %}{{ airsonic.domain }}{% else %}{{ airsonic.subdomain + "." + domain }}{% endif %}/) or [http://{% if airsonic.domain %}{{ airsonic.domain }}{% else %}{{ airsonic.subdomain + "." + domain }}{% endif %}/](http://{% if airsonic.domain %}{{ airsonic.domain }}{% else %}{{ airsonic.subdomain + "." + domain }}{% endif %}/)

{% if enable_tor %}
It is also available via Tor at [http://{{ apache2.subdomain + "." + tor_domain }}/](http://{{ apache2.subdomain + "." + tor_domain }}/)
{% endif %}
