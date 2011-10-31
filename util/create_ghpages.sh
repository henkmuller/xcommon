#!/bin/sh

# Copyright (c) 2011, XMOS Ltd, All rights reserved
# This software is freely distributable under a derivative of the
# University of Illinois/NCSA Open Source License posted in
# LICENSE.txt and at <http://github.xcore.com/>

if [ $# -ne 1 ]
then
    echo "Usage: $0 <reponame>"
    exit 1
fi

mod=$1

if [ -e ${mod}_gh_pages ]
then
    echo "${mod}_gh_pages already exists"
    exit 1
fi

if [ ! -d ${mod} -o ! -d ${mod}/.git ]
then
    echo "Repo ${mod} not checked out here - quitting"
    exit 2
fi

echo "About to create empty documentation branch ${mod}_gh_pages"
echo "This is a clone of the ${mod} repository on branch gh-pages"
echo "Hit return or ^C"

read x

git clone git@github.com:xcore/${mod}.git ${mod}_gh_pages || exit 1

cd ${mod}_gh_pages || exit 1

git symbolic-ref HEAD refs/heads/gh-pages || exit 1
rm .git/index || exit 1
git clean -fdx || exit 1

touch .nojekyll
git add .nojekyll
git commit -a -m "First pages commit"

git push origin gh-pages
