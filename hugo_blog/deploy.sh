echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

rm -rf public/posts/*
rm -rf public/me/*
rm -rf public/GPA/*
hugo

cd public
git add -A

msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

git push origin main
