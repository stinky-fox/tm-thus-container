# About

This is a containerised version of the original Trend Micro Hybrid Cloud Security Command Line Interface (https://github.com/trendmicro/thus) if you want to avoid installing python 3.9 on your host system or just willing to test THUS without any deplyment burden. 

Container is Alpine Linux based with the jq as an additional tool that can help you with JSON parsing. 

THUS examples can be found in the original repo - https://github.com/trendmicro/thus/blob/master/doc/example.md

# Run

THUS require to have 2 config files under ~/.thus directory - **credentials** and **config**. You should create them on your host system prior the container deployment. Alternatively you may run thus --config inside the container. 

### Typical THUS config example: 

```
[default]
dsmverifyssl = True
dsmhost = https://app.deepsecurity.trendmicro.com/api
```
### Typical THUS credentials example:

```
[default]
dsmapikey = <YOUR C1WS API KEY HERE>
```

### Run the container

```# docker run -itd -v "/path/to/config:/root/.thus/config" -v "/path/to/credentials:/root/.thus/credentials" --name thus puffago/tm-thus-container:latest ```

To access the container and have auto-completion capabilities please run **bash** intead of sh

```# docker exec -it thus bash```

# Disclaimer

This repository has no any relations to Trend Micro company. 
Maintained and updated during the maintainers free hours. 
