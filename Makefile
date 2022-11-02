NAME=inception

all: clean run 

clean:
		@sudo docker-compose -f Inception/srcs/docker-compose.yml down

run:
		@ mkdir -p /home/ybrutout/mariadb
		@sudo docker-compose -f Inception/srcs/docker-compose.yml up