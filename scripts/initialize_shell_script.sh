#!/usr/bin/env bash
set -eu

scriptName="${1}.sh"

echo '#!/usr/bin/env bash
set -eu

'> "${scriptName}"
chmod +x "${scriptName}"
$EDITOR "${scriptName}"
