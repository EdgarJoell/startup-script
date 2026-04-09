HOMEBREW_PACKAGES=("git" "node" "ruby" "typescript" "mongosh" "nvm" "postgresql" "dotnet")
HOMEBREW_CASKS=("webstorm" "rubymine" "intellij-idea" "rider" "visual-studio-code" "jetbrains-toolbox" "datagrip" "pgadmin4" "dbeaver-community" "clion" "pycharm")
NPM_PACKAGES=("@angular/cli" "typescript" "ts-node" "nodemon" "create-next-app" "react-native-cli" "expo-cli" "electron")

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

printf "\nStep 2: Installing Homebrew Packages\n"

for hbPackage in "${HOMEBREW_PACKAGES[@]}"; do
  printf "\nInstalling %s...\n" "$hbPackage"

  if ! brew list "$hbPackage" &>/dev/null; then
    brew install "$hbPackage"
  else
    printf "%s already installed, skipping, \n" "$hbPackage"
  fi
done

printf "\nStep 3: Installing Homebrew Casks (AKA: IDE's and other Development Application\n"

for hbCask in "${HOMEBREW_CASKS[@]}"; do
  printf "\nInstalling %s...\n" "$hbCask"

  if ! brew list "$hbCask" &>/dev/null; then
    brew install "$hbCask"
  else
    printf "%s already installed, skipping, \n" "$hbCask"
  fi
done

printf "\nStep 4: Installing NPM packages\n"

for npmPackage in "${NPM_PACKAGES[@]}"; do
  printf "\nInstalling %s...\n" "$npmPackage"

  if ! brew list "$npmPackage" &>/dev/null; then
    brew install "$npmPackage"
  else
    printf "%s already installed, skipping, \n" "$npmPackage"
  fi
done

#  Python has to be separate because Apple Silicon comes with a System Python by default, we don't want that So we'll run Python without a system check.
printf "\nStep 5: Installing Python...\n"
brew install python

#  mongodb-community has to be separate because MongoDB has their own Homebrew repository and we need to 'tap' Homebrew to check external Homebrew sources in order to bring in mongodb-community
echo -e "\nStep 6: Installing mongodb-community..."

if ! brew list mongodb-community &>/dev/null; then
  brew tap mongodb/brew
  brew install mongodb-community
else
  echo "mongodb-community already installed, skipping,"
fi

#  Run openjdk separately because we're not just installing one JDK version but four so that the user has the choice of which Java version to use (11, 17, 21, 25)

printf "\nStep 7: Installing OpenJDK..."

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

printf  "\nPerforming cleanup and finalizing the Startup Script\n"

brew cleanup
npm cache clean --force

printf "\nFinalizing Script...\n"
echo "Completed. Happy Coding!"
