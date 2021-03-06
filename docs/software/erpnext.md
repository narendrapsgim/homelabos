# ERPNext

[ERPNext](https://github.com/frappe/frappe_docker) Open Source ERP for Everyone.

## Setup

On your server run:

```
chmod -R 777 {{ volumes_root }}/erpnext/
```

then

```
docker exec -it -e "SITE_NAME={% if erpnext.domain %}{{ erpnext.domain }}{% else %}{{ erpnext.subdomain + "." + domain }}{% endif %}" -e "SITES={% if erpnext.domain %}{{ erpnext.domain }}{% else %}{{ erpnext.subdomain + "." + domain }}{% endif %}" -e "ADMIN_PASSWORD=PASS" -e "INSTALL_APPS=erpnext" -e "FORCE=1" erpnext_erpnext-python_1 docker-entrypoint.sh new
```

## Access

It is available at [https://{% if erpnext.domain %}{{ erpnext.domain }}{% else %}{{ erpnext.subdomain + "." + domain }}{% endif %}/](https://{% if erpnext.domain %}{{ erpnext.domain }}{% else %}{{ erpnext.subdomain + "." + domain }}{% endif %}/) or [http://{% if erpnext.domain %}{{ erpnext.domain }}{% else %}{{ erpnext.subdomain + "." + domain }}{% endif %}/](http://{% if erpnext.domain %}{{ erpnext.domain }}{% else %}{{ erpnext.subdomain + "." + domain }}{% endif %}/)

{% if enable_tor %}
It is also available via Tor at [http://{{ erpnext.subdomain + "." + tor_domain }}/](http://{{ erpnext.subdomain + "." + tor_domain }}/)
{% endif %}

## Security enable/disable https_only and auth

To enable https_only or auth set the service config to True
`settings/config.yml`

```
erpnext:
  https_only: True
  auth: True
```