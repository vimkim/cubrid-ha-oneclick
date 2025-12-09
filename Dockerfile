FROM quay.io/rockylinux/rockylinux:9.7.20251123-ubi

RUN dnf -y install wget ca-certificates vim sudo && dnf clean all

# cubrid 사용자 생성
RUN useradd -m cubrid && echo "cubrid:cubrid" | chpasswd

# wheel 그룹에 추가 (Rocky/RHEL의 sudo 그룹)
RUN usermod -aG wheel cubrid

# sudo 설정: wheel 그룹 비밀번호 없이 허용 + audit 비활성화
RUN echo "%wheel ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/wheel-nopasswd \
    && echo "Defaults !use_audit" > /etc/sudoers.d/no-audit \
    && chmod 440 /etc/sudoers.d/wheel-nopasswd /etc/sudoers.d/no-audit

WORKDIR /home/cubrid

ENV CUBRID=/home/cubrid/CUBRID
ENV PATH=$CUBRID/bin:$PATH

COPY docker-entrypoint.sh /home/cubrid/docker-entrypoint.sh
RUN chown cubrid:cubrid /home/cubrid/docker-entrypoint.sh \
    && chmod +x /home/cubrid/docker-entrypoint.sh

USER cubrid
ENTRYPOINT ["/home/cubrid/docker-entrypoint.sh"]

