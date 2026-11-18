#!/usr/bin/env python3
"""
Build a three-column TSV manifest for STAR:
Column 1 = full path to R1 FASTQ
Column 2 = full path to R2 FASTQ
Column 3 = sample name

Assumes input 3 files have no headers and one entry per line.
Script written with ChatGPT!
How to run the script: 
python3 build_star_manifest.py \
  --r1-file r1_list.txt \
  --r2-file r2_list.txt \
  --samples-file samples_list.txt \
  --base-path /data/fastq \
  --out star_manifest.tsv
"""

import argparse
import sys
from pathlib import Path

def read_lines(path: Path):
    try:
        with path.open("r", encoding="utf-8") as f:
            return [ln.strip() for ln in f if ln.strip()]
    except FileNotFoundError:
        print(f"ERROR: Cannot open {path}", file=sys.stderr)
        sys.exit(1)

def core_pair_key(name: str) -> str:
    """
    Heuristic to map R1/R2 mates to the same core by normalizing typical paired patterns.
    Adjust if your naming scheme differs.
    """
    # Normalize common paired tokens to a single placeholder
    rep = (
        name.replace("_R1", "_R").replace("_R2", "_R")
            .replace(".R1", ".R").replace(".R2", ".R")
            .replace("_1.", "_.").replace("_2.", "_.")
            .replace("_1_", "_._").replace("_2_", "_._")
    )
    return rep

def sample_matches_filename(sample: str, filename: str) -> bool:
    """
    Check if the sample name appears at the start of the filename or as a distinct token.
    Works well for accessions like SRR25360829.
    """
    base = Path(filename).name
    if base.startswith(sample):
        return True
    # Also try token-based match up to first '_' or '.'
    token = base.split("_")[0].split(".")[0]
    return token == sample

def build_manifest(r1_list, r2_list, samples, base_path: Path, out_path: Path, check_exists: bool):
    n1, n2, ns = len(r1_list), len(r2_list), len(samples)
    if not (n1 == n2 == ns):
        print(f"ERROR: Line counts differ: R1={n1}, R2={n2}, Samples={ns}", file=sys.stderr)
        sys.exit(1)

    warnings = []

    # Validate pairing heuristics
    for i, (r1, r2, s) in enumerate(zip(r1_list, r2_list, samples), start=1):
        # R1 vs R2 core check
        if core_pair_key(r1) != core_pair_key(r2):
            warnings.append(f"[Line {i}] R1/R2 may not be mates:\n    R1: {r1}\n    R2: {r2}")

        # Sample vs filename consistency
        if not sample_matches_filename(s, r1):
            warnings.append(f"[Line {i}] Sample does not match R1 filename:\n    Sample: {s}\n    R1: {r1}")
        if not sample_matches_filename(s, r2):
            warnings.append(f"[Line {i}] Sample does not match R2 filename:\n    Sample: {s}\n    R2: {r2}")

    # Prepare output rows and optionally verify existence
    rows = []
    missing = []
    for r1, r2, s in zip(r1_list, r2_list, samples):
        p1 = (base_path / r1).resolve()
        p2 = (base_path / r2).resolve()

        if check_exists:
            if not p1.exists():
                missing.append(str(p1))
            if not p2.exists():
                missing.append(str(p2))

        rows.append((str(p1), str(p2), s))

    # Report warnings
    if warnings:
        print("WARNINGS (pairing/name checks):", file=sys.stderr)
        for w in warnings[:20]:
            print(" -", w, file=sys.stderr)
        if len(warnings) > 20:
            print(f" ... and {len(warnings)-20} more", file=sys.stderr)

    # Report missing files (if checking enabled)
    if check_exists and missing:
        print("ERROR: The following paths do not exist:", file=sys.stderr)
        for m in missing:
            print(" -", m, file=sys.stderr)
        sys.exit(1)

    # Write manifest
    try:
        with out_path.open("w", encoding="utf-8") as out:
            for p1, p2, s in rows:
                out.write(f"{p1}\t{p2}\t{s}\n")
    except Exception as e:
        print(f"ERROR: Failed to write manifest: {e}", file=sys.stderr)
        sys.exit(1)

    print(f"Manifest written: {out_path} ({len(rows)} rows)")
    return 0

def main():
    ap = argparse.ArgumentParser(description="Create STAR three-column TSV manifest (R1, R2, Sample).")
    ap.add_argument("--r1-file", required=True, type=Path, help="Text file with R1 FASTQ filenames (one per line).")
    ap.add_argument("--r2-file", required=True, type=Path, help="Text file with R2 FASTQ filenames (one per line).")
    ap.add_argument("--samples-file", required=True, type=Path, help="Text file with sample names (one per line).")
    ap.add_argument("--base-path", required=True, type=Path, help="Directory path where FASTQ files reside.")
    ap.add_argument("--out", default=Path("star_manifest.tsv"), type=Path, help="Output TSV manifest path.")
    ap.add_argument("--no-exists-check", action="store_true", help="Skip file existence check (default: check).")
    args = ap.parse_args()

    r1_list = read_lines(args.r1_file)
    r2_list = read_lines(args.r2_file)
    samples = read_lines(args.samples_file)

    check_exists = not args.no_exists_check
    sys.exit(
        build_manifest(
            r1_list=r1_list,
            r2_list=r2_list,
            samples=samples,
            base_path=args.base_path,
            out_path=args.out,
            check_exists=check_exists,
        )
    )

if __name__ == "__main__":
    main()
