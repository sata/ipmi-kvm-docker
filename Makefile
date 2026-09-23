IMAGE     := ipmi-kvm
CONTAINER := ipmi-kvm
PORT      := 8080
RES       := 1920x1000x24
URL       ?=

.PHONY: build
build:
	docker build -t $(IMAGE) .

.PHONY: run
run: build
	@[ -n "$(URL)" ] || (echo "Usage: make run URL=https://your-ipmi-host" && exit 1)
	docker run -d \
		--name $(CONTAINER) \
		--rm \
		-p $(PORT):8080 \
		-e RES=$(RES) \
		-e URL=$(URL) \
		$(IMAGE)

.PHONY: type
type:
	@read -s -p "Text to type: " t && echo && \
		docker exec $(CONTAINER) xdotool type --clearmodifiers --delay 50 "$$t"

.PHONY: stop
stop:
	docker stop $(CONTAINER)
