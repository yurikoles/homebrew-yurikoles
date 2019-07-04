#/usr/bin/env bash -ex

for file in "$@"; do
    if [[ $file =~ .rb$ ]] ; then
        brew style $file
    	brew audit --strict --online --new-formula $file
    	brew install $file -vd
    fi
done
