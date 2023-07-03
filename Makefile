layout     ?= default
target_dir ?= target
id         ?= ch-id

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

.PHONY: set-version
set-version:
ifndef version
	$(error No version given. Aborting)
endif
	$(info Packaging version: $(version))
	mvn versions:set -DnewVersion=$(version) -DgenerateBackupPoms=false

.PHONY: package
package: set-version
	mvn package -DskipTests=true

.PHONY: dist
dist: clean package

.PHONY: local-deploy
local-deploy: set-version clean
	mvn deploy -U  -DskipTests=true -DaltDeploymentRepository=$(id)::$(layout)::file://$(target_dir)

.PHONY: publish
publish:
	mvn jar:jar deploy:deploy

.PHONY: sonar
sonar:
	mvn sonar:sonar

.PHONY: sonar-pr-analysis
sonar-pr-analysis:
	mvn sonar:sonar -P sonar-pr-analysis
