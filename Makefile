IMAGE_NAME := recipe-website
CONTAINER_NAME := recipe-website
PORT := 8080:80

.PHONY: build run start stop clean

all: run

build:
	docker build -t $(IMAGE_NAME) .

run: build
	docker run -d -p $(PORT) --name $(CONTAINER_NAME) $(IMAGE_NAME)

start:
	docker start $(CONTAINER_NAME)

stop:
	docker stop $(CONTAINER_NAME)

clean:
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true
	docker rmi $(IMAGE_NAME) || true
