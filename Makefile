REPO := hub.docker.com/myresume
IMAGE := www
CVBUILD := cvbuild

BUILD := $(shell cat BUILD)

TEX = $(wildcard htdocs/resume/*.tex)
PDF = $(patsubst htdocs/resume/%.tex, htdocs/resume/%.pdf, $(TEX))

.PHONY: all
all: cv docker

.PHONY: .build
.build:
	@if ! test -f BUILD; then echo 0 > BUILD; fi
	@echo $$(($$(cat BUILD) + 1)) > BUILD

.PHONY: docker-cvbuild
docker-cvbuild: Dockerfile-$(CVBUILD)
	docker build $(OPTARGS) \
		-t $(CVBUILD):latest \
		-f Dockerfile-$(CVBUILD) .

htdocs/resume/%.pdf: htdocs/resume/%.tex docker-cvbuild
	docker run --rm -v .:/tmp $(CVBUILD):latest ./makepdf.sh $<

.PHONY: cv
cv: $(PDF) docker-cvbuild

.PHONY: docker
docker: .build
	docker build $(OPTARGS) \
		-t $(REPO)$(IMAGE):latest \
		-f Dockerfile .

.PHONY: docker-force
docker-force:
	docker build $(OPTARGS) \
		--no-cache
		-t $(REPO)$(IMAGE):latest \
		-f Dockerfile .

.PHONY: tag
tag: BUILD
	git add BUILD
	test `git diff HEAD BUILD|wc -l` != 0
	git ci -m "Bump build to $(BUILD)"
	git tag $(BUILD)
	docker tag $(OPTARGS) \
		$(REPO)$(IMAGE):latest \
		$(REPO)$(IMAGE):$(BUILD)

.PHONY: push
push:
	docker push $(OPTARGS) \
		$(REPO)$(IMAGE):latest
	docker push $(OPTARGS) \
		$(REPO)$(IMAGE):${BUILD}
	git push --tags

.PHONY: push-force
push-force:
	docker push $(OPTARGS) \
		$(REPO)$(IMAGE):latest

.PHONY: clean
clean:
	docker images|grep "none" |awk '{print $$3}' | tail -n +2 | xargs docker rmi -f

.PHONY: clean-all
clean-all: clean
	rm -f htdocs/resume/*.pdf
	rm -f htdocs/resume/*.synctex.gz
	docker images | tail -n +2|awk '{print $$3}'|xargs docker rmi -f
	docker builder prune -af
