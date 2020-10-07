VERSION_FILE=.version
NOW_VERSION:=$(shell cat ${VERSION_FILE})
INCREMENT_PARAM=bug
VERSION_SH_URL=https://gist.githubusercontent.com/a4t/c75d5b7adb049e506784f9b8dd16de4d/raw/c13a3b77614a8ff9c7a5c6c1ff672ed92393ef88/version.sh

version+:;   $(MAKE) version-increment INCREMENT_PARAM=bug
version++:;  $(MAKE) version-increment INCREMENT_PARAM=feature
version+++:; $(MAKE) version-increment INCREMENT_PARAM=major
version-increment:
	curl -sSL ${VERSION_SH_URL} | bash -s ${NOW_VERSION} ${INCREMENT_PARAM} > ${VERSION_FILE}

release-tag:
	git tag ${NOW_VERSION}
	git push origin ${NOW_VERSION}

release-branch:
	git checkout -b releases/${NOW_VERSION}

# Terraform
ENVIRONMENT=
ENVIRONMENT_DIR=/terraform/environments
ENVIRONMENT_VOLUMES=-v ${CURDIR}${ENVIRONMENT_DIR}/${ENVIRONMENT}:${ENVIRONMENT_DIR}/${ENVIRONMENT} -v ${CURDIR}/terraform/common:/terraform/common

create_environment:
	docker run --rm -v "$$PWD/terraform":/terraform bash bash -c "[ ! -d ${ENVIRONMENT_DIR}/${ENVIRONMENT} ] && cp -rp ${ENVIRONMENT_DIR}/{template,${ENVIRONMENT}}"

terraform-init:
	docker-compose run --rm terraform-${ENVIRONMENT} init

terraform-apply:
	docker-compose run --rm terraform-${ENVIRONMENT} apply -auto-approve

terraform-plan:
	docker-compose run --rm terraform-${ENVIRONMENT} plan

terraform-fmt:
	docker-compose run --rm -w /terraform terraform-${ENVIRONMENT} fmt -recursive -check

.PHONY: terraform
