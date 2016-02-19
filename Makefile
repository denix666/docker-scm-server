# To forse build use -B switch
##############################
default: clean all

all:
	docker build -t denix666/scm-server:1.46 .

clean:
	docker ps -a | grep Exited | awk '{print $1}' | xargs -r docker rm
	docker images --no-trunc| grep none | awk '{print $3}' | xargs -r docker rmi
