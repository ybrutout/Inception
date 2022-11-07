NAME=inception

all: clean run

start:
		sudo docker-compose -f ./srcs/docker-compose.yml start

stop:
		sudo docker-compose -f ./srcs/docker-compose.yml stop

clean:
		sudo docker-compose -f ./srcs/docker-compose.yml down
		sudo docker system prune -a -f --volumes

fclean: clean
		sudo rm -rf /home/ybrutout/data/
		sudo docker volume rm srcs_mariadb-volume


run:
		mkdir -p /home/ybrutout/data/mariadb
		mkdir -p /home/ybrutout/data/wordpress
		sudo chmod 777 /etc/hosts
		echo "127.0.0.1 ybrutout.42.fr" >> /etc/hosts
		sudo docker-compose -f ./srcs/docker-compose.yml up --build