FROM quay.io/rockylinux/rockylinux:9.7.20251123-ubi

# 필요한 패키지 설치
RUN dnf -y install wget ca-certificates vim sudo && dnf clean all

# cubrid 사용자 생성
RUN useradd -m cubrid

WORKDIR /home/cubrid

ENV CUBRID=/home/cubrid/CUBRID
ENV PATH=$CUBRID/bin:$PATH

# 엔트리포인트 스크립트 복사 (root로 실행됨)
COPY docker-entrypoint.sh /home/cubrid/docker-entrypoint.sh

# 소유권 및 실행권한 설정 (여전히 root)
RUN chown cubrid:cubrid /home/cubrid/docker-entrypoint.sh \
    && chmod +x /home/cubrid/docker-entrypoint.sh

# 여기서부터 컨테이너는 cubrid 사용자로 실행
USER cubrid

ENTRYPOINT ["/home/cubrid/docker-entrypoint.sh"]

