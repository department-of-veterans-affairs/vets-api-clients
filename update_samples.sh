dir="oauth_php/VetsApiClaims"
echo "### update: $dir"
(
  cd "samples/$dir"
  composer update
)


JS_PROJECTS="oauth_node oauth_php/VetsApiClaims oauth_pkce_cli oauth_react"
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
