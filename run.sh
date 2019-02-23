#!/bin/bash

# the default node number is 3
N=${1:-3}


# start hadoop master container
sudo docker rm -f hadoop-master &> /dev/null
echo "start hadoop-master container..."
sudo docker run -itd \
                --network hadoop-net \
                --publish 50070:50070 \
                --publish 8088:8088 \
                --name hadoop-master \
                --hostname hadoop-master \
                jasonchau/hadoop-cluster:latest &> /dev/null


# start hadoop slave container
i=1
while [ $i -lt $N ]
do
	sudo docker rm -f hadoop-slave$i &> /dev/null
	echo "start hadoop-slave$i container..."
	sudo docker run -itd \
	                --network hadoop-net \
	                --name hadoop-slave$i \
	                --hostname hadoop-slave$i \
	                jasonchau/hadoop-cluster:latest &> /dev/null
	i=$(( $i + 1 ))
done

# get into hadoop master container
#sudo docker exec -it hadoop-master bash
