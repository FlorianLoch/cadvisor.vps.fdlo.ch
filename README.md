# cadvisor in Dokku

This repository contains the configuration of the cadvisor instance running at vps.fdlo.ch.

Following the instructions in https://richardwillis.info/blog/monitor-dokku-server-prometheus-loki-grafana.

Add a git remote for Dokku:
```bash
git remote add dokku dokku@vps.fdlo.ch:cadvisor
```

Additionally, some setup with Dokku is necessary:

```bash
dokku apps:create cadvisor

dokku storage:mount cadvisor /:/rootfs:ro
dokku storage:mount cadvisor /sys:/sys:ro
dokku storage:mount cadvisor /var/lib/docker:/var/lib/docker:ro
dokku storage:mount cadvisor /var/run:/var/run:rw

dokku http-auth:on cadvisor <username> <password>

dokku network:set cadvisor attach-post-deploy prometheus-bridge

# Apps needs to be deployed once before calling this
dokku proxy:ports-set cadvisor http:80:8080
dokku domains:remove cadvisor cadvisor.fdlo.ch
dokku domains:add cadvisor cadvisor.vps.fdlo.ch

dokku letsencrypt:enable cadvisor
```
