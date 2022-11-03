NAME=inception

all: clean run

start
		sudo docker-compose -f ./srcs/docker-compose.yml start

stop:
		sudo docker-compose -f ./srcs/docker-compose.yml stop

clean:
		sudo docker-compose -f ./srcs/docker-compose.yml down
		sudo docker system prune -a -f


run:
		mkdir -p /home/ybrutout/mariadb
		sudo docker-compose -f ./srcs/docker-compose.yml up --build