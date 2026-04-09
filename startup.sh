HOMEBREW_PACKAGES=("git" "node" "ruby" "typescript" "mongosh" "nvm" "postgresql" "dotnet")

printf "Beginning Process of setting up Mac machine for development...\n"

printf "\nStep 1: Installing Homebrew to machine...\n"

if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [[ "$(uname -m)" == "arm64" ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  echo "Homebrew already installed, skipping."
fi

printf "\nContinuing on to install software and tools via Homebrew...\n"

printf "\nStep 2: Installing Node.JS..."

if ! brew list node &>/dev/null; then
   echo "Installing the latest LTS Node.JS developer tool..."
    brew install npm
else
   echo "Node already installed, skipping,"
fi

printf "\nStep 3: Installing Ruby..."

if ! brew list ruby &>/dev/null; then
   echo "Installing the Ruby programming language..."
    brew install ruby
else
   echo "Ruby already installed, skipping,"
fi

printf "\nStep 4: Installing Ruby..."

if ! brew list typescript &>/dev/null; then
   echo "Installing the TypeScript programming language..."
    brew install typescript
else
   echo "TypeScript already installed, skipping,"
fi

printf "\nStep 5: Installing Python..."

if ! brew list python &>/dev/null; then
   echo "Installing the Python programming language..."
   brew install python
else
   echo "Python already installed, skipping,"
fi

printf "\nStep 6: Installing OpenJDK..."

if ! brew list openjdk &>/dev/null; then
   INCORRECT_VALUE=1

   while [ "$INCORRECT_VALUE" -eq 1 ]
   do
      read -r -t 10 -p "Which Java version would you like as your main version? Allowed versions: 11, 17, 21, 25 (if no version is specified, this script defaults to 21): " version

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

   printf "\nLinking default JDK version to the version specified...\n"

   brew link openjdk@"$version"
else
   echo "OpenJDK already installed, skipping,"
fi

printf "\nStep 7: Installing mongodb-community..."

if ! brew list mongodb-community &>/dev/null; then
  brew tap mongodb/brew
  brew install mongodb-community
else
  echo "mongodb-community already installed, skipping,"
fi

printf "\nStep 8: Installing mongosh..."

if ! brew list mongosh &>/dev/null; then
   echo "Installing the mongosh developer tool..."
   brew install mongosh
else
   echo "mongosh already installed, skipping,"
fi

printf "\nStep 9: Installing Node Version Manager (NVM)..."

if ! brew list nvm &>/dev/null; then
   echo "Installing the nvm developer tool..."
   brew install nvm
else
   echo "nvm already installed, skipping,"
fi

printf "\nStep 10: Installing PostgreSQL..."

if ! brew list postgresql &>/dev/null; then
  brew install postgresql
else
  echo "PostgreSQL already installed, skipping,"
fi

printf "\nStep 11: Installing .NET..."

if ! brew list dotnet &>/dev/null; then
   brew install dotnet
else
   echo ".NET already installed, skipping,"
fi

printf "\nBeginning installations for Developers IDE's...\n"

printf "\nStep 1: Installing JetBrains WebStorm...\n"

if ! brew list --cask webstorm &>/dev/null; then
  brew install --cask webstorm
else
  echo "JetBrains WebStorm already installed, skipping,"
fi

printf "\nStep 2: Installing JetBrains RubyMine...\n"

if ! brew list --cask rubymine &>/dev/null; then
  brew install --cask rubymine
else
  echo "JetBrains RubyMine already installed, skipping,"
fi

printf "\nStep 3: Installing JetBrains IntelliJ Ultimate...\n"

if ! brew list --cask intellij-idea &>/dev/null; then
  brew install --cask intellij-idea
else
  echo "JetBrains IntelliJ Ultimate already installed, skipping,"
fi

printf "\nStep 4: Installing JetBrains Rider...\n"

if ! brew list --cask rider &>/dev/null; then
  brew install --cask rider
else
  echo "JetBrains Rider already installed, skipping,"
fi

printf "\nStep 5: Installing Visual Studio Code...\n"

if ! brew list --cask visual-studio-code &>/dev/null; then
  brew install --cask visual-studio-code
else
  echo "Visual Studio Code already installed, skipping,"
fi

printf "\nStep 6: Installing JetBrains ToolBox...\n"

if ! brew list --cask jetbrains-toolbox &>/dev/null; then
  brew install --cask jetbrains-toolbox
else
  echo "JetBrains ToolBox already installed, skipping,"
fi

printf "\nStep 7: Installing JetBrains DataGrip...\n"

if ! brew list --cask datagrip &>/dev/null; then
  brew install --cask datagrip
else
  echo "JetBrains DataGrip already installed, skipping,"
fi

printf "\nStep 11: Installing pgAdmin4..."

if ! brew list --cask pgadmin4 &>/dev/null; then
  brew install --cask pgadmin4
else
  echo "pgAdmin4 already installed, skipping,"
fi

printf "\nBeginning to install NPM packages\n"

printf "\nStep 1: Installing Angular CLI..."

if ! npm list -g @angular/cli &>/dev/null; then
  npm install -g @angular/cli
else
  echo "Angular CLI already installed, skipping."
fi

printf "\nStep 2: Installing ts-node..."

if ! npm list -g ts-node &>/dev/null; then
  npm install -g ts-node
else
  echo "ts-node already installed, skipping."
fi

printf "\nStep 3: Installing nodemon..."

if ! npm list -g nodemon &>/dev/null; then
  npm install -g nodemon
else
  echo "nodemon already installed, skipping."
fi

printf "\nStep 4: Installing create-next-app..."

if ! npm list -g create-next-app &>/dev/null; then
  npm install -g create-next-app
else
  echo "create-next-app already installed, skipping."
fi

printf "\nStep 5: Installing react-native-cli..."

if ! npm list -g react-native-cli &>/dev/null; then
  npm install -g react-native-cli
else
  echo "react-native-cli already installed, skipping."
fi

printf "\nStep 6: Installing expo-cli..."

if ! npm list -g expo-cli &>/dev/null; then
  npm install -g expo-cli
else
  echo "expo-cli already installed, skipping."
fi

printf "\nStep 7: Installing electron..."

if ! npm list -g electron &>/dev/null; then
  npm install -g electron
else
  echo "electron already installed, skipping."
fi

printf  "\nPerforming cleanup and finalizing the Startup Script\n"

brew cleanup
npm cache clean --force

printf "\nFinalizing Script...\n"
echo "Completed. Happy Coding!"
