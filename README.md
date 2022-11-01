# julie-ops-demo
Demonstration repo for explaing julie ops for kafka to the team

execute the following docker with julieops

BROKERS=opmv:9902; \
docker run -t -i \
-v $PWD/:/example \
purbon/kafka-topology-builder:latest \
julie-ops-cli.sh \
--brokers $BROKERS \
--clientConfig /example/juliops-rules.properties \
--overridingClientConfig /example/localkafka.properties \
--topology /example/businesssoftware.yaml


BROKERS=opmv:9902; \
docker run -t -i \
-v $PWD/:/example \
purbon/kafka-topology-builder:latest \
julie-ops-cli.sh \
--brokers $BROKERS \
--clientConfig /example/juliops-rules.properties \
--overridingClientConfig /example/localkafkaconnect.properties \
--topology /example/businesssoftware-connect.yaml