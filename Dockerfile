FROM debian
USER root
RUN apt update -y && apt install -y curl vim jq && \
  latest="https://api.github.com/repos/sharkdp/hyperfine/releases/latest" && \
  ver=$(curl -sS "$latest" | jq -r .zipball_url) && test -n "$ver" && \
  ver=${ver##*/} && deb="hyperfine_${ver#v}_amd64.deb" && \
	url="https://github.com/sharkdp/hyperfine/releases/download/$ver/$deb" && \
	curl -sSLO "$url" && dpkg -i ./*.deb
COPY Dockerfile entrypoint /
ENTRYPOINT ["sh","/entrypoint"]
