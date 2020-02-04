#!/usr/bin/env bash
set -eu

TEST_SIZE=1000
TEST_COUNT=10

TARGET_DISKS=(
  'e:'
  'g:'
)

function write_bench() {
  cd "$1"
  if [[ ! -d bench ]]; then
    mkdir bench
  fi
  for ((i=0;i<TEST_COUNT;i++)); do
    dd if=/dev/zero of="bench/$i" bs=1M count="$TEST_SIZE" 2>&1 | tail -1
  done
  rm bench/*
}

for disk in "${TARGET_DISKS[@]}"; do
  echo "$disk"
  write_bench "$disk"
done
