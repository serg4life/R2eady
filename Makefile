VERSION=1.0-1
NAME=project-configurator

DESTDIR=

default: install

.PHONY: install
install:
	@echo "Installing $(NAME) version $(VERSION)..."
	install -d $(DESTDIR)/etc/$(NAME)
	cp -r docker $(DESTDIR)/etc/$(NAME)/
	install -m 755 initialize_repo.sh $(DESTDIR)/usr/bin/$(NAME)


.PHONY: clean
clean:
	@echo "Cleaning up $(NAME)..."
	rm -f $(DESTDIR)/usr/bin/$(NAME)
	rm -rf $(DESTDIR)/etc/$(NAME)
