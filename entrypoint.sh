#!/usr/bin/env bash
set -e
set -o pipefail
echo ">>> Starting"
echo ""

bash -c "set -e; set -o pipefail; echo 'labs-validator version'; labs-validator --version"

if [ $1 = "trivy" ]
then
  echo ">>> Trivy mode"
  echo "Trivy version"
  bash -c "set -e; set -o pipefail; trivy --version"
  echo ">>> Trivy scanning table output"
  bash -c "set -e; set -o pipefail; trivy config -f table -s HIGH,CRITICAL ."
  echo ">>> Trivy scanning json file output"
  bash -c "set -e; set -o pipefail; trivy config -f json -s HIGH,CRITICAL -o trivy.json ."
  echo ">>> Validating results against labs.safestack.io"
  bash -c "set -e; set -o pipefail; labs-validator trivy -json=trivy.json"
fi
