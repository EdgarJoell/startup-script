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

echo "\nContinuing on to install software and tools via Homebrew...\n"

echo "\nStep 2: Installing Node.JS..." 

if ! brew list | grep node &>/dev/null; then
   echo "Installing the latest LTS Node.JS developer tool..."
    brew install npm
else
   echo "Node already installed, skipping,"
fi

echo "\nStep 3: Installing Ruby..." 

if ! brew list | grep ruby &>/dev/null; then
   echo "Installing the Ruby programming language..."
    brew install ruby
else
   echo "Ruby already installed, skipping,"
fi

echo "\nStep 4: Installing Ruby..." 

if ! brew list | grep typescript &>/dev/null; then
   echo "Installing the TypeScript programming language..."
    brew install typescript
else
   echo "TypeScript already installed, skipping,"
fi

echo "\nStep 5: Installing Python..." 

if ! brew list | grep python &>/dev/null; then
   echo "Installing the Python programming language..."
   brew install python
else
   echo "Python already installed, skipping,"
fi

echo "\nStep 6: Installing OpenJDK..." 

if ! brew list | grep openjdk &>/dev/null; then
   INCORRECT_VALUE=1

   while [ "$INCORRECT_VALUE" -eq 1 ]
   do
      read -t 10 -p "Which Java version would you like as your main version? Allowed versions: 11, 17, 21, 25 (if no version is specified, this script defaults to 21): " version

      if [ "$version" = "" ]; then 
         version=21
      fi 

      if [[ "$version" =~ ^(11|17|21|25)$ ]]; then
         INCORRECT_VALUE=0
         echo "Continuing..."
      else
         echo "Incorrect value, please try again."
      fi
   done

   echo "Installing the OpenJDK's..."
   brew install openjdk@11
   brew install openjdk@17
   brew install openjdk@21
   brew install openjdk@25

   echo "\nLinking default JDK version to the version specified...\n"

   brew link openjdk@$version
else
   echo "OpenJDK already installed, skipping,"
fi

echo "\nStep 7: Installing mongodb-community..." 

if ! brew list | grep mongodb-community &>/dev/null; then
   echo "Installing the mongodb-community database..."
   brew install mongodb-community
else
   echo "mongodb-community already installed, skipping,"
fi

echo "\nStep 8: Installing mongosh..." 

if ! brew list | grep mongosh &>/dev/null; then
   echo "Installing the mongosh developer tool..."
   brew install mongosh
else
   echo "mongosh already installed, skipping,"
fi

echo "\nStep 8: Installing Node Version Manager (NVM)..." 

if ! brew list | grep nvm &>/dev/null; then
   echo "Installing the nvm developer tool..."
   brew install nvm
else
   echo "nvm already installed, skipping,"
fi

# echo "Finalizing Script..."

# # Add some clean up right here

# echo "Completed. Happy Coding!"

