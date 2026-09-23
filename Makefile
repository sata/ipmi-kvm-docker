IMAGE     := ipmi-kvm
CONTAINER := ipmi-kvm
PORT      := 8080
RES       := 1920x1000x24

.PHONY: build
build:
	docker build -t $(IMAGE) .

.PHONY: run
run: build
	docker run -d \
		--name $(CONTAINER) \
		--rm \
		-p $(PORT):8080 \
		-e RES=$(RES) \
		$(IMAGE)

.PHONY: type
type:
	@read -s -p "Text to type: " t && echo && \
		docker exec $(CONTAINER) xdotool type --clearmodifiers --delay 50 "$$t"

.PHONY: stop
stop:
	docker stop $(CONTAINER)
