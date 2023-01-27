FROM registry.access.redhat.com/ubi8/ubi

RUN dnf update -y; \
    curl -s https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable/openshift-client-linux.tar.gz --output /root/openshift-client-linux.tar.gz; \
    tar -xvzf /root/openshift-client-linux.tar.gz -C /root; \
    mv /root/oc /root/kubectl  /usr/local/bin/ ; \
    curl -Ls https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.19.4/kubeseal-0.19.4-linux-amd64.tar.gz --output /root/kubeseal.tar.gz; \
    tar -xvzf /root/kubeseal.tar.gz -C /root; \
    mv /root/kubeseal /usr/local/bin/ ; \
    curl -Ls https://raw.githubusercontent.com/redhat-cop/gitops-catalog/main/sealed-secrets-operator/scripts/replace-sealed-secrets-secret.sh --output /usr/local/bin/replace-sealed-secrets-secret; \
    chmod +x /usr/local/bin/replace-sealed-secrets-secret

COPY fetch_and_apply.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/fetch_and_apply.sh; \ 
    mkdir /fetched; \
    chmod a+rwx /fetched
WORKDIR /fetched
USER 1001
CMD "fetch_and_apply.sh"
