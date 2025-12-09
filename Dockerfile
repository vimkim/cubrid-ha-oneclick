FROM quay.io/rockylinux/rockylinux:9.7.20251123-ubi

# 필요한 패키지 설치
RUN dnf -y install wget ca-certificates && dnf clean all

# CUBRID 설치 (버전/URL은 실제에 맞게 수정 필요)
RUN useradd -m cubrid
USER cubrid
WORKDIR /home/cubrid

ENV CUBRID=/home/cubrid/CUBRID
ENV PATH=$CUBRID/bin:$PATH

# 엔트리포인트 스크립트 복사
COPY docker-entrypoint.sh /home/cubrid/docker-entrypoint.sh
RUN chmod +x /home/cubrid/docker-entrypoint.sh

ENTRYPOINT ["/home/cubrid/docker-entrypoint.sh"]

