IMAGE := slamdev/tiny-maven-proxy

.PHONY: build
build:
	docker build -t $(IMAGE) .
	docker push $(IMAGE)

.PHONY: test
test:
	curl http://tiny-maven-proxy.svc.cluster.local/ | jq
