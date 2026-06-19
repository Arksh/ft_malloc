##Colors #
RED		= @echo "\033[0;31m"
GREEN	= @echo "\033[0;32m"
BLUE	= @echo "\033[0;33m"
PURPLE	= @echo "\033[0;34m"
CYAN	= @echo "\033[0;35m"
RESET	= "\033[1;0m"

#	file's name
NAME	= 

#	compilation
CC		= gcc

#	options to force the remove
RM		= /bin/rm -f

#	flags
#------------------------------------------------------------------------------
CFLAGS		= -Wall -Werror -Wextra

LEAK_FLAGS	= -fsanitize=address -g3 -pedantic

INCLUDES	= -I $(INCLUDE_DIR) -I $(READ)/include

LIBS		= -L $(LIBFT_DIR) -lft -lreadline -L $(READ)/lib

#------------------------------------------------------------------------------

# Directories
BIN_DIR		= bin
SRC_DIR		= srcs
SRCS		= main.c
LIBFT_DIR	= libft		# path to libft libft
INCLUDE_DIR	= include		# path to headers


# to search the direccion of the library
# type "find / -name libreadline.a 2>/dev/null"
# if not installed in your user
# type "brew install readline"

# Convert source files to binary
OBJS = $(SRCS:%.c=$(BIN_DIR)/%.o)

all: $(NAME)

restart: $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) $(INCLUDES) $(LIBS) -o $(NAME)

$(NAME): $(BIN) $(OBJS) # | lib
	@echo "\033[0;32mCompiling $(NAME)..."
	$(CC) $(CFLAGS) $(OBJS) $(INCLUDES) $(LIBS) -o $(NAME)
	@echo "\n\033[0mDone !"

#	Objects construction
$(OBJS): $(BIN_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(@D)
	@printf "\033[0;33mGenerating $(NAME) objects... %-33.33s\r" $@
	@$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

#	Libraries compile
lib:
	@make -C $(LIBFT_DIR)

re: fclean all

leaks: $(BIN) $(OBJS) | lib
	@echo "\033[0;32mCompiling $(NAME) with sanitizer..."
	$(CC) $(CFLAGS) $(LEAK_FLAGS) $(OBJS) $(INCLUDES) $(LIBS) -o $(NAME)
	@echo "\n\033[0mDone !"

clean:
	@echo "\nRemoving binaries..."
	@$(RM) $(OBJS)
	@echo "\033[0;31mCleaning libft..."
	@make clean -C $(LIBFT_DIR)
	@$(RM) -r $(BIN_DIR)
	@echo "\033[0m"

fclean: clean
	@echo "\033[0;31mFcleaning libft..."
	@make fclean -C $(LIBFT_DIR)
	@echo "\nDeleting executable..."
	@$(RM) $(NAME)
	@echo "\033[0m"

.PHONY: $(LIBFT) all clean fclean re