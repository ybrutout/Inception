NAME=inception

all: clean run 

stop:
		sudo docker-compose -f Inception/srcs/docker-compose.yml down

clean: stop
		

run:
		mkdir -p /home/ybrutout/mariadb
		sudo docker-compose -f Inception/srcs/docker-compose.yml up