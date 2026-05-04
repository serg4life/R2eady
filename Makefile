VERSION=1.0-1
NAME := project-configurator
CONFIG_DIR := /etc/$(NAME)
DESTDIR=

default: install

.PHONY: install
install:
	install -d $(DESTDIR)${CONFIG_DIR}
	cp -r toolsets $(DESTDIR)${CONFIG_DIR}/
	install -m 755 initialize_repo.sh $(DESTDIR)/usr/bin/$(NAME)


.PHONY: clean
clean:
	rm -f $(DESTDIR)/usr/bin/$(NAME)
	rm -rf $(DESTDIR)${CONFIG_DIR}
