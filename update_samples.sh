dir="oauth_php/VetsApiClaims"
echo "### update: $dir"
(
  cd "samples/$dir"
  composer update
)


RAILS_PROJECTS="oauth_rails/VetsApiClaims oauth_rails/vethealth oauth_rails/vetverification"
for dir in $RAILS_PROJECTS
do
  echo "### update: $dir"
  (
    cd "samples/$dir"
    bin/bundle update
  )
done


JS_PROJECTS="benefits-intake oauth_node oauth_php/VetsApiClaims oauth_pkce_cli oauth_rails/VetsApiClaims oauth_rails/vethealth oauth_rails/vetverification oauth_react"
for dir in $JS_PROJECTS
do
  echo "### update: $dir"
  (
    cd "samples/$dir"
    npm update
  )
done
for dir in $JS_PROJECTS
do
  echo "### audit: $dir"
  (
    cd "samples/$dir"
    npm audit --json
  )
done
