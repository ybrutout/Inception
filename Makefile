NAME=inception

all: clean run 

stop:
		sudo docker-compose -f ./srcs/docker-compose.yml down

clean: stop
		sudo docker system prune


run:
		mkdir -p /home/ybrutout/mariadb
		sudo docker-compose -f ./srcs/docker-compose.yml up