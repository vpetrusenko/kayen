VERSION := $(shell cat VERSION)
IMAGE   := gcr.io/helios-devel/kayen:$(VERSION)

.PHONY: default build push run ci deploy

default: build run

build:
	@echo '> Building "kayen" docker image...'
	@docker build -t $(IMAGE) .

push: build
	gcloud docker -- push $(IMAGE)

run:
	@echo '> Starting "kayen" container...'
	@docker run -d $(IMAGE)

ci:
	@fly -t ci set-pipeline -p kayen -c config/pipelines/review.yml -n
	@fly -t ci unpause-pipeline -p kayen

deploy: push
	@helm install ./config/charts/kayen --set "image.tag=$(VERSION)"
