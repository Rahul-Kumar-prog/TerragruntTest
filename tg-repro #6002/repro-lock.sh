#!/usr/bin/env bash
set -u

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
workdir="$(mktemp -d /private/tmp/tg-repro-6002.XXXXXX)"

cp -R \
  "$repo_dir/root.hcl" \
  "$repo_dir/consumer" \
  "$repo_dir/shared_dep" \
  "$repo_dir"/unit_* \
  "$workdir/"

echo "Using clean repro copy: $workdir"
echo
echo "1. Force the dependency-output/init race against shared_dep."
echo "   Expected failure signature: Error locking state: resource temporarily unavailable"
(
  cd "$workdir/shared_dep" || exit 1

  terragrunt init -no-color > "$workdir/init.log" 2>&1 &
  init_pid=$!

  terragrunt output -no-color > "$workdir/output.log" 2>&1 &
  output_pid=$!

  wait "$init_pid"
  init_status=$?

  wait "$output_pid"
  output_status=$?

  echo
  echo "terragrunt init exit:   $init_status"
  echo "terragrunt output exit: $output_status"
  echo
  echo "--- init.log ---"
  sed -n '1,160p' "$workdir/init.log"
  echo
  echo "--- output.log ---"
  sed -n '1,220p' "$workdir/output.log"

  if grep -q "resource temporarily unavailable" "$workdir/init.log" "$workdir/output.log"; then
    exit 0
  fi

  exit 1
)
forced_status=$?

echo
echo "2. Smoke test the actual issue command. On fast machines this can pass."
(
  cd "$workdir" || exit 1
  terragrunt run --all -- plan -no-color
)
run_all_status=$?

echo
echo "run --all status:     $run_all_status"
echo "forced race status:   $forced_status"
echo "logs kept under:      $workdir"

exit "$forced_status"
