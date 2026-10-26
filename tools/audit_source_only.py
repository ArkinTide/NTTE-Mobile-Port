"""Reject non-source paths or binary blobs from Git source distribution."""
from pathlib import Path
import argparse,json
from source_only_policy import audit
p=argparse.ArgumentParser(description=__doc__)
g=p.add_mutually_exclusive_group();g.add_argument('--history',action='store_true');g.add_argument('--index',action='store_true')
a=p.parse_args();result=audit(Path(__file__).resolve().parents[1],history=a.history,index=a.index)
print(json.dumps(result,ensure_ascii=False,indent=2))
raise SystemExit(0 if result['status']=='PASS' else 1)
