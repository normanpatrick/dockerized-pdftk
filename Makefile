SHELL := /bin/bash
cname := debian-pdftk

homepath := ${HOME}/temp-workspace/pdftk-home

help:
	@echo "-----------------------------------------------------------"
	@echo "build         : build container"
	@echo "build-no-cache: same as above, use no-cache"
	@echo "clean         : delete the workspace expanded iso files etc."
	@echo "run           : run container"
	@echo "root          : run as root, for debugging"
	@echo "-----------------------------------------------------------"

build:
	@docker build -t ${cname} .

build-no-cache:
	@docker build --no-cache -t ${cname} .

clean: dir_prereq
	@echo "Doing nothing for now"

run: dir_prereq
	docker run -it --rm \
		-u $(shell id -u ${USER}):$(shell id -g ${USER}) \
		-v /etc/passwd:/etc/passwd:ro \
		-v /etc/group:/etc/group:ro \
		-v ${PWD}:/work \
		-v ${homepath}/${USER}:/home/${USER} \
		--workdir /work \
		${cname}

root: dir_prereq
	docker run -it --rm \
		-v ${PWD}:/work \
		-v ${homepath}/root:/home/root \
		--workdir /work \
		${cname}

dir_prereq:
	@echo "Create dirs, if needed"
	@mkdir -p ${homepath}
	@mkdir -p ${homepath}/${USER}
	@mkdir -p ${homepath}/root
