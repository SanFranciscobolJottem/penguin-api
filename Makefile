APP = penguin-api
BIN_LINUX = ./bin/$(APP)
CMD_SRC = ./cmd/$(APP)/main.go

build: 
	go build -o $(BIN_LINUX) $(CMD_SRC)

run: build
	$(BIN_LINUX) --address 127.0.0.1 --port 8081

clean:
	rm -rf bin/

# Docker-specific targets
local-docker-build:
	docker build -t localhost/$(APP):dev .

local-docker-run:
	docker run --rm localhost/$(APP):dev

# GCloud-specific targets
gcloud-docker-init:
	gcloud auth configure-docker

gcloud-docker-build:
	docker build -t gcr.io/$(GCP_PROJECT_ID)/$(APP):$(ENVIRONMENT) .

gcloud-docker-push:
	docker push gcr.io/$(GCP_PROJECT_ID)/$(APP):$(ENVIRONMENT)

gcloud-run-deploy:
	gcloud run deploy $(APP)-$(ENVIRONMENT) \
	--region europe-west2 \
	--image gcr.io/$(GCP_PROJECT_ID)/$(APP):$(ENVIRONMENT) \
	--port 80 \
	--project $(GCP_PROJECT_ID) \
	--max-instances 1 \
	--platform managed \
	--labels environment=$(ENVIRONMENT) \
	--allow-unauthenticated 
