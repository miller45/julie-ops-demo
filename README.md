# julie-ops-demo
Demonstration repo for explaing julie ops for kafka to the team

execute the following docker with julieops
```
BROKERS=opmv:9902; \
docker run -t -i \
-v $PWD/:/example \
purbon/kafka-topology-builder:latest \
julie-ops-cli.sh \
--brokers $BROKERS \
--clientConfig /example/juliops-rules.properties \
--overridingClientConfig /example/localkafka.properties \
--topology /example/businesssoftware.yaml
```

Important example for configuring kafka-connect..put each kafka-connect server in you .properties file.
The items are numbered 0..n. After the = follows a name that can be used in the topology file (e.g. cloud-connect). The
actual server address will then be taken from the config below.
platform.servers.connect.0=connect:http://opmv:8083
platform.servers.connect.1=cloud-connect:https://group0-connect.kafka.cloud:8083
