PY := python3.10
PYTHON_VERSION = 3.10
VENV := venv
REPONAME=$(basename $(pwd))
DOCKER=docker
DOCKER_COMPOSE = docker compose


.PHONY: build_docs up_docs down_docs restart_docs clean_docs

.PHONY: help
help:
	@echo 
	@echo "- \make install"

${VENV}:
	@echo "Create venv"
	${PY} -m venv ./${VENV}
	@echo "Update pip"
	./${VENV}/bin/python3 -m pip install --upgrade pip
	./${VENV}/bin/pip install poetry
	./${VENV}/bin/pip install -r requirements.txt

.PHONY: install
install: $(VENV)
	@echo "Installed project in virtual environment..."
	@echo "Linux: Use \"source venv/bin/activate\""
#	@echo "Linux: Run \"poetry install\""
	@echo ${REPONAME}


.PHONY: clean
clean: ${VENV}
	rm -rf dist
	rm -rf ${VENV}
	rm -rf poetry.lock
#	find . -type f -name *.pyc -delete
#	find . -type d -name __pycache__ -delete

############# Docs ############
DOCKERFILE_DIR_DOCS := ./src/containers/docs
IMAGE_NAME_DOCS := python-docs
CONTAINER_NAME_DOCS := python-docs
PORT_DOCS := 8080

# Construye la imagen Docker usando el Dockerfile en /src/containers/docs/
build_docs:
	$(DOCKER) build -t $(IMAGE_NAME_DOCS) -f $(DOCKERFILE_DIR_DOCS)/Dockerfile .

# Levanta el contenedor y expone el puerto 8080 (con live-reload y montado de volumen)
run_docs:
#	 $(DOCKER) run --rm -it -p $(PORT_DOCS):$(PORT_DOCS) -v $(PWD):/app $(IMAGE_NAME_DOCS)
	$(DOCKER) run --rm -it \
		--name $(CONTAINER_NAME_DOCS) \
		-p $(PORT_DOCS):$(PORT_DOCS) \
		-v $(PWD):/app \
		$(IMAGE_NAME_DOCS)

# Detiene y elimina el contenedor (si está en segundo plano)
clean_docs:
	$(DOCKER) stop $(CONTAINER_NAME_DOCS) || true
	$(DOCKER) rm $(IMAGE_NAME_DOCS) || true

# Atajo para build + run
up_docs: build_docs run_docs