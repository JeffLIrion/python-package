#!/bin/bash

set -e

# if no arguments are passed, create the pre-commit hook
if [ "$#" -eq 0 ]; then
  read -p "Do you want to setup the git pre-commit hook? [Y/n]  " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    # setup pre-commit hook
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
    echo -e "#!/bin/bash\n\n./scripts/pre-commit.sh 'placeholder_argument'" > "$DIR/../.git/hooks/pre-commit"
    chmod a+x "$DIR/../.git/hooks/pre-commit"
    echo "pre-commit hook successfully configured"
  else
    echo "pre-commit hook not configured"
  fi
  exit 0
fi

# THE PRE-COMMIT HOOK

# get the directory of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# get the package name
PACKAGE=$($DIR/get_package_name.sh)

(
  cd "$DIR/.."

  # flake8
  flake8_pass=true
  echo -e "\nRunning flake8..."
  flake8 "$PACKAGE/" || flake8_pass=false

  # pylint
  pylint_pass=true
  echo -e "\nRunning pylint..."
  pylint "$PACKAGE/" || pylint_pass=false

  if [ "$flake8_pass" != "true" ] || [ "$pylint_pass" != "true" ]; then
    echo "fail"
    exit 1
  fi
  echo "pass"
)
