##
## EPITECH PROJECT, 2021
## makefile
## File description:
## makefile
##

BIN_PATH	:=	$(shell stack path --local-install-root)
NAME			=	wolfram

all:
	stack build
	cp $(BIN_PATH)/bin/$(NAME)-exe ./$(Name)
	mv wolfram-exe wolfram

clean:
	stack clean

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re
