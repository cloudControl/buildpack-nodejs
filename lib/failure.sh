warnings=$(mktemp -t buildpack-nodejs-XXXX)

failure_message() {
  local warn="$(cat $warnings)"
  echo ""
  echo "We're sorry this build is failing!"
  echo ""
  if [ "$warn" != "" ]; then
    echo "Some possible problems:"
    echo ""
    echo "$warn"
  else
    echo "If you're stuck, please submit a ticket so we can help."
  fi
  echo ""
}

fail_invalid_package_json() {
  if ! cat ${1:-}/package.json | $JQ "." 1>/dev/null; then
    error "Unable to parse package.json"
    return 1
  fi
}

warning() {
  local tip=${1:-}
  local url=${2:-https://www.cloudcontrol.com/dev-center/guides}
  echo "- $tip" >> $warnings
  echo "  $url" >> $warnings
  echo "" >> $warnings
}

warn_node_engine() {
  local node_engine=${1:-}
  if [ "$node_engine" == "" ]; then
    warning "Node version not specified in package.json"
  elif [ "$node_engine" == "*" ]; then
    warning "Dangerous semver range (*) in engines.node"
  elif [ ${node_engine:0:1} == ">" ]; then
    warning "Dangerous semver range (>) in engines.node"
  fi
}

warn_prebuilt_modules() {
  local build_dir=${1:-}
  if [ -e "$build_dir/node_modules" ]; then
    warning "node_modules checked into source control" "https://www.npmjs.org/doc/misc/npm-faq.html#should-i-check-my-node_modules-folder-into-git-"
  fi
}

warn_missing_package_json() {
  local build_dir=${1:-}
  if ! [ -e "$build_dir/package.json" ]; then
    warning "No package.json found"
  fi
}

warn_old_npm() {
  local npm_version="$(npm --version)"
  if [ "${npm_version:0:1}" -lt "2" ]; then
    local latest_npm="$(curl --silent --get https://semver.io/npm/stable)"
    warning "This version of npm ($npm_version) has several known issues - consider upgrading to the latest release ($latest_npm)"
  fi
}
