#!/bin/bash
set -e

# 환경 변수 로드
source "$CUBRID/.cubrid.sh"

# 컨테이너가 죽지 않도록 대기
tail -f /dev/null

