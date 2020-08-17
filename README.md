# C-Gate Server
A Docker image of Clipsal's C-Gate Server for interfacing with existing Clipsal C-Bus Networks.
* Runs as unprivileged user 'cgate' (UID/GID 24283)
* See the [C-Gate Website](https://updates.clipsal.com/ClipsalSoftwareDownload/mainsite/cis/technical/downloads/c-gate.html) for Manuals, Release Notes, and Protocol Documentation.

## Usage
* Existing C-Bus XML Project files can be added into the `/cgate/tag` directory
* C-Gate Server configuration is performed in `/cgate/config/C-GateConfig.txt`
* Remote Access Controls are configured in `/cgate/config/access.txt`


### Docker
```bash
docker create \
    --name=cgate \
    -p 20023:20023 \
    -p 20024:20024 \
    -p 20025:20025 \
    -p 20026:20026 \
    -p 20123:20123 \
    -p 20124:20124 \
    -p 20125:20125 \
    -p 20126:20126 \
    -v path/to/config:/cgate/config \
    -v path/to/logs:/cgate/logs \
    -v path/to/tag:/cgate/tag \
    --restart unless-stopped \
    rjmidau/cgate
```

### Docker Compose
``` yaml
---
version: '2.1'
services:
  cgate:
    image: rjmidau/cgate
    container_name: cgate
    ports:
        - 20023:20023
        - 20024:20024
        - 20025:20025
        - 20026:20026
        - 20123:20123
        - 20124:20124
        - 20125:20125
        - 20126:20126
    volumes:
        - path/to/config:/cgate/config
        - path/to/logs:/cgate/logs
        - path/to/tag:/cgate/tag
    restart: unless-stopped
```

## Parameters

| Parameter | Function |
| :----: | --- |
| `-p 20023` | C-Gate Command Interface |
| `-p 20024` | C-Gate Event Interface  |
| `-p 20025` | C-Gate Status Change Port (SCP) |
| `-p 20026` | C-Gate Config Change Port (CCP) |
| `-p 2012x` | As above, but with SSL Enabled |
| `-v /cgate/config` | C-Gate configuration files |
| `-v /cgate/logs` | C-Gate Log files |
| `-v /cgate/tag` | C-Bus Project Files |
