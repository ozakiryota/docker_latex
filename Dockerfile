########## Pull ##########
FROM ubuntu:22.04
########## User ##########
ARG home_dir="/home/user"
COPY copy/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN apt-get update && \
	apt-get install -y \
		gosu \
		sudo && \
	chmod +x /usr/local/bin/entrypoint.sh && \
	mkdir -p $home_dir
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
########## Non-interactive ##########
ENV DEBIAN_FRONTEND=noninteractive
########## compiler ##########
RUN apt-get update && \
	apt-get install -y \
		texlive-lang-cjk \
		texlive-fonts-recommended \
		texlive-fonts-extra \
		texlive-science \
		texlive-bibtex-extra \
		biber
########## diff ##########
RUN apt-get update && \
	apt-get install -y latexdiff
########## viewer ##########
RUN apt-get update && \
	apt-get install -y \
		evince \
		xdvik-ja
########## Initial position ##########
WORKDIR $home_dir/latex_ws
CMD ["bash"]