DIRS=bootstrap persistence infrastructure data-load services management
STAGING_DIRS=persistence infrastructure data-load
REMOVE=management services data-load infrastructure
CONFIRM=
WORKSPACE=sandbox

all:
	for d in $(DIRS); do (cd $$d; make refresh plan apply || exit 1); done

bootstrap:
	cd bootstrap; make refresh plan apply || exit 1

destroy: 
	for d in $(REMOVE); do (cd $$d; make destroy CONFIRM=$(CONFIRM) ); done

workspace:
	for d in $(DIRS); do (cd $$d; terraform workspace select $(WORKSPACE) || terraform workspace new $(WORKSPACE) ); done

init:
	for d in $(DIRS); do (cd $$d; terraform init); done

stage:
	for d in $(STAGING_DIRS); do (cd $$d; make refresh plan apply); done


