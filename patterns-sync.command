cd ~/Sites/quaivecloud

git -C _data/patterns checkout master
git -C _data/patterns pull

git -C _includes/patterns checkout master
git -C _includes/patterns pull

git -C _sass/libraries/patterns checkout master
git -C _sass/libraries/patterns pull

git -C _layouts/patterns checkout master
git -C _layouts/patterns pull

git -C _data/patterns commit -a -m "Update patterns" 
git -C _data/patterns push
git -C _includes/patterns commit -a -m "Update patterns" 
git -C _includes/patterns push 
git -C _sass/libraries/patterns commit -a -m "Update patterns" 
git -C _sass/libraries/patterns push
git -C _layouts/patterns commit -a -m "Update patterns" 
git -C _layouts/patterns push

