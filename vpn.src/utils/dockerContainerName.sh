## *
## Get Docker container name.
##
## *: Key
## Out: Docker container name.

local k="$*"
k="$(echo "$k" | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/[-]+$//' | sed -E 's/^[-]+//')"
echo "vpn-$k"
