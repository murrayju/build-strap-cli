#!/bin/bash
downloadDir=$(pwd)/download
mkdir -p "$downloadDir"

uname=$(uname -s)
if [ "$(getconf LONG_BIT)" == "64" ]; then
  arch=64
else
  arch=86
fi

# we need jq to parse the package.json
jqCmd=$(which jq 2>/dev/null || echo "$downloadDir/jq")
if [ ! -f "$jqCmd" ]; then
  echo Failed to find jq, run ./bs
  exit
fi

nodeVersion=$($jqCmd -r .buildStrap.nodeVersion package.json)
yarnVersion=$($jqCmd -r .buildStrap.yarnVersion package.json)
nodeVersionParts=(${nodeVersion//./ })
if [[ $uname =~ ^Darwin* ]]; then
  if [[ ${nodeVersionParts[0]} -ge 16 ]] && [ "$(arch)" == "arm64" ]; then
    nodeName=node-v$nodeVersion-darwin-arm64
  else
    nodeName=node-v$nodeVersion-darwin-x$arch
  fi
elif [[ $uname =~ ^Linux* ]]; then
  if [[ ${nodeVersionParts[0]} -ge 16 ]] && { [ "$(arch)" == "aarch64" ] || [ "$(arch)" == "arm64" ]; }; then
    nodeName=node-v$nodeVersion-linux-arm64
  else
    nodeName=node-v$nodeVersion-linux-x$arch
  fi
else
  echo "Unknown os: $uname"
  exit
fi
nodeGz=$nodeName.tar.gz
nodeUrl=https://nodejs.org/dist/v$nodeVersion/$nodeGz
nodeDl=$downloadDir/$nodeGz

if [ ! -f "$nodeDl" ]; then
  echo "Downloading $nodeUrl to $nodeDl"
  curl -o "$nodeDl" "$nodeUrl"
fi

nodeDir=$downloadDir/$nodeName
export PATH=$nodeDir/bin:$PATH
export nodeCmd=$nodeDir/bin/node
export npmCmd=$nodeDir/bin/npm
if [ ! -f "$npmCmd" ]; then
  echo Extracting node gz
  tar xzf "$nodeDl" -C "$downloadDir"
fi
modulesDir=$nodeDir/node_modules
mkdir -p "$modulesDir"

yarnUrl=https://yarnpkg.com/downloads/$yarnVersion/yarn-v$yarnVersion.tar.gz
yarnDl=$downloadDir/yarn-v$yarnVersion.tar.gz
yarnDir=$modulesDir/yarn

if [ ! -f "$yarnDl" ]; then
  echo "Downloading $yarnUrl to $yarnDl"
  curl -L -o "$yarnDl" "$yarnUrl"
  if [ -d "$yarnDir" ]; then
    rm -r "$yarnDir"
  fi
fi

export PATH=$yarnDir/bin:$PATH
export yarnJs=$yarnDir/bin/yarn.js
if [ ! -f "$yarnJs" ]; then
  echo Extracting yarn gz
  tar xzf "$yarnDl" -C "$nodeDir/node_modules/"
  mv "$modulesDir/yarn-v$yarnVersion/" "$yarnDir/"
fi
