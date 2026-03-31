echo "Beginning Process of setting up Mac machine for development...\n"

echo "\nStep 1: Installing Homebrew to machine...\n" 

if ! command -v brew &>/dev/null; then
   echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
   echo "Homebrew already installed, skipping."
fi

if [[ "$(uname -m)" == "arm64" ]]; then
   echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
   eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "\nStep 2: Installing Node.JS via Homebrew..." 

if ! brew list | grep node &>/dev/null; then
   echo "Installing the latest LTS from Node.JS via Homebrew..."
    brew install npm
else
   echo "Node already installed, skipping,"
fi

echo "\nStep 3: Installing Ruby via Homebrew..." 

if ! brew list | grep ruby &>/dev/null; then
   echo "Installing the Ruby programming language via Homebrew..."
    brew install ruby
else
   echo "Ruby already installed, skipping,"
fi

echo "\nStep 4: Installing Ruby via Homebrew..." 

if ! brew list | grep typescript &>/dev/null; then
   echo "Installing the TypeScript programming language via Homebrew..."
    brew install typescript
else
   echo "TypeScript already installed, skipping,"
fi

# echo "Finalizing Script..."

# # Add some clean up right here

# echo "Completed. Happy Coding!"

