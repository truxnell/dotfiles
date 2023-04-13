#!/bin/bash
# Ensure shell is changed to fish

# Define colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print a message with a color
print_msg() {
	local msg=$1
	local color=$2
	echo -e "${color}${msg}${NC}"
}

print_msg "Ensure Fish shell ===========================================" $YELLOW

# Set fish as default shell
if [ $SHELL != $(which fish) ]; then

	print_msg "Changing shell to fish ===========================================" $GREEN
	echo "Changing default shell to fish"
	chsh -s $(which fish)
else
	print_msg "Shell already fish ===========================================" $GREEN
fi
