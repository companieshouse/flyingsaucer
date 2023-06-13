SHELL := /bin/bash

# link the required jar files to publish into a main ./target dir
# as that is where Concourse maven task will look into:
# https://github.com/companieshouse/ci-concourse-resources/blob/8bd37b/tasks/java-8/oracle-jdk/maven/build-package-library/task.yml#L26
MAIN_TARGET_DIR := ./target

# list the required modules to export
MODULES_TO_PUBLISH := flying-saucer-pdf
# at the time of writing only 1 module (flying-saucer-pdf) is used:
# https://github.com/companieshouse/document-render-from-html5/blob/0379e05/pom.xml#L32
# anyhow just list any other desired modules i.e. MODULES_TO_PUBLISH := flying-saucer-pdf  flying-saucer-swt flying-saucer-core

.PHONY: all
all: build

.PHONY: clean
clean:
	mvn clean

.PHONY: build
build:
	mvn compile

.PHONY: test
test: test-unit

.PHONY: test-unit
test-unit:
	mvn test

.PHONY: package
package:
ifndef version
	$(error No version given. Aborting)
endif
	$(info Packaging version: $(version))
	mvn versions:set -DnewVersion=$(version) -DgenerateBackupPoms=false
	mvn package -DskipTests=true
	@echo  "creating sym.links in $(MAIN_TARGET_DIR) to jar files in [$(MODULES_TO_PUBLISH)]:"
	$(shell mkdir -p $(MAIN_TARGET_DIR))
	$(foreach MODULE,$(MODULES_TO_PUBLISH), \
	   for jar in $(MODULE)/target/*.jar; do \
	   ln -sf ../$$jar $(MAIN_TARGET_DIR)/`basename $$jar`; \
	   done ; \
	)

.PHONY: dist
dist: clean package

.PHONY: publish
publish:
	mvn jar:jar deploy:deploy

.PHONY: sonar
sonar:
	mvn sonar:sonar

.PHONY: sonar-pr-analysis
sonar-pr-analysis:
	mvn sonar:sonar -P sonar-pr-analysis
