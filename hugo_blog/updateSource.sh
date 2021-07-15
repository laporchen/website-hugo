echo -e "\033[0;32mUpdate source to GitHub...\033[0m"

git add -A

msg="Update source `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

git push origin main