NAME=inception

all: clean run

start:
		sudo docker-compose -f ./srcs/docker-compose.yml start

stop:
		sudo docker-compose -f ./srcs/docker-compose.yml stop

clean:
		sudo docker-compose -f ./srcs/docker-compose.yml down
		sudo docker system prune -a -f

fclean: clean
		sudo rm -rf /home/ybrutout/data/
		sudo docker volume rm srcs_mariadb-volume


run:
		mkdir -p /home/ybrutout/data/mariadb
		sudo docker-compose -f ./srcs/docker-compose.yml up --build